Return-Path: <linux-kernel+bounces-843711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC925BC00CF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 04:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90C444E1FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594F1F4CB3;
	Tue,  7 Oct 2025 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="hPlVM721"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DC1662E7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759805779; cv=none; b=A2FaSH93zWSAT/kf/L5wyb04TBFPPj22ZW1lbWscJl6VN9GKdBW/NeDqVd0uDzXrsHVmRe5hUK0BDPT1nis8wmXdvGswtiw4ir1gGQcALlOrE3gAMUeBAovPKV5TxJha7pCLA9/xTi+wc0gEYtbkNBPTtY8HjR7RAUXbS3SgHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759805779; c=relaxed/simple;
	bh=fuFAPKshWl//JiXRjMB35HbsTIfb2+26+cuu4EjKaKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQiW5MPvKK9AAcvF19Ln3bZkHL8HpZbOuIerL9a9lPPO8PADytmZeQie5N90muEGdPV0J7aDm9BBj0arR5FFdReAwfcBT38lxnOU08vivZ9uoE8vcKjUBZfgt+eXATQ9WyXVjHu4CgzZ/koKWU0U4uM6TWe/uOyRwOfJ/aw9+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=hPlVM721; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-77f947312a5so47674137b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 19:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1759805777; x=1760410577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuFAPKshWl//JiXRjMB35HbsTIfb2+26+cuu4EjKaKg=;
        b=hPlVM721TgeVjFwhVnKlXC1zv/TXS90X2HqbyhPOvSdpDAAsOASRBYlTJh8zJPd2gg
         WZ8pe+JCtfzQACzcUjTidy91Vn/3XxL20lqPcaz1hbgqs8u8ymg7TbIci4ny7EZa4ZDK
         zvTNUmfYDdf80yPUKoLkLC/F3h7PPLOBxJiaGQrXlqCfw6z8/C03zWqt7XM4TmrKrQlj
         Xv7WzNHHYm8Tc9P7H5sysTLAic+k6ewQAfj/PdLjRHh9ZW7V1nmH6VMn+zqja0lceV/g
         7m+U8dCaCKX5+sQcaqgx4YT1S5pw/KoxAcTNmseUdm8QjVv0hCY1V+aXT8t8v4UmTpYg
         Xd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759805777; x=1760410577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuFAPKshWl//JiXRjMB35HbsTIfb2+26+cuu4EjKaKg=;
        b=gACo1fopxJfKi3YxoAwxKLKLCC2Z+5Ly9wEkhs2CALAfJwVQSXL4qJk5SzxCVvQ0MG
         hEmo3ZLl0X9dmw2HnTFUETZrFefRUbl7zCKLpdDm4Tyk/F3hjgplnXRqiIUGuHalaWml
         BjZW7cdsKBOXyJQEKGXCmNx1A2kcY+vBzJ9FbuJvWW8HHY3jobNUhaEOD/pfEtbAAkTL
         xnjxzvEKunep75F31m9ez6KubCW7MP8tsi1+8xSy3wSQhaicExHIDjp5JP9defwChuPv
         n0OxhgcTKOSAj5T7W2ukWx6+nsYRMsxCl7MbeTVnAG/JP4j1JCEOlkEhmF0poxGj4aKS
         o+lA==
X-Forwarded-Encrypted: i=1; AJvYcCVw4AZDYK8l2QAkbkkMhTUi9/aIK4oJ+Eefe5uOs4aq9onEQYYuoOJeVccCRLZyObPU65NU2q0Muz+iGAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXutTZLYfZvCkaZCsDFOzLW06UNGGhDpVz/WZ5CuJOgJB1kPTQ
	b5nKOzaOK9T2RTHo/f0y+P7d3fhFeR0lB2533rFvMdz+4qSorqPsQm6bZvCZ5YYpIpyvyt41JaC
	Om+QQi7LCs2KHpGhM8XXRC5AjlK3BeLB0ku+/R8+Blg==
X-Gm-Gg: ASbGncv4a6HG4VUFSYF7Go/WBmodGTCUeOBXbHp6xEDL+CZ8PwUDnNE8V0no5TaISws
	iU52B6nnFoIQHGER611LAGgJ+xlqLiyJrF/9EjARwAA1PJmKVx2Y+8YMum/wE2cBCJp74b8gGq8
	2bB17K09UCr8GnEc7Y6R62CMrOYx8BS9ZgM+XZGUWy9o1v8FCVDk908uS18dzPkLey6qGt4+Kks
	+xEGjM3XKf95Tkj9GCS+EUWk59u0z4=
X-Google-Smtp-Source: AGHT+IGiL5ZbUyw4GIm1wEiPzbvi0bFG0G6zf6Qg7uBuzVV7lluUj++swICMyX/mIRT04h7owb9dsBoqFDjT19u1Wdo=
X-Received: by 2002:a53:a090:0:b0:635:4ecd:75a5 with SMTP id
 956f58d0204a3-63b9a107b85mr10946438d50.51.1759805777473; Mon, 06 Oct 2025
 19:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006-tt-bh-dts-v2-0-ed90dc4b3e22@oss.tenstorrent.com>
 <20251006-tt-bh-dts-v2-6-ed90dc4b3e22@oss.tenstorrent.com> <a05be32b-dc8f-444f-8c1c-2d49eb19536d@kernel.org>
In-Reply-To: <a05be32b-dc8f-444f-8c1c-2d49eb19536d@kernel.org>
From: Joel Stanley <jms@tenstorrent.com>
Date: Tue, 7 Oct 2025 13:26:01 +1030
X-Gm-Features: AS18NWDhncaNX_AgRBWrUJDmiFjfXWDY84NNzl_Nu5rdMYVHwC56fOAaV3Fa3Jw
Message-ID: <CAM3sHeBweq285Mwqzwd7no3zwzoosRgsHkunnVkYSgHyh37eAw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] riscv: dts: Add Tenstorrent Blackhole SoC PCIe cards
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, Arnd Bergmann <arnd@arndb.de>, 
	Joel Stanley <joel@jms.id.au>, Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@kernel.org>, Andy Gross <agross@kernel.org>, 
	Anirudh Srinivasan <asrinivasan@tenstorrent.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Drew Fustini <dfustini@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 11:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> You should have at least serial or any other interface, otherwise I
> don't see how this can be used at this stage.

If you read the cover letter it explains how it is used:

 > The HVC SBI console is sufficient for boot testing.

