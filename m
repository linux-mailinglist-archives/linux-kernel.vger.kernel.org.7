Return-Path: <linux-kernel+bounces-892498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E3C45365
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FFE3A9F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39D2EBB86;
	Mon, 10 Nov 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DpY0Ea+W"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4FE227B9F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759669; cv=none; b=QcT/QgwI7qTU9M72rsY3dc/N9xxVr7/MK2vO/H0sMpCIrWewwUDSw0DDDtPyZe8GrsDy26RwlrJ4/fKhF2F0wdxAmTIS+k+oU4yKss1Ns/kUEB/fQ+Di+njAOHeCoTqqoaftZWbEMFX+WIMpU/B3LKOOOlAHGGa76O62tSbCXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759669; c=relaxed/simple;
	bh=BPGUWrjgAY/FIkzGZIG2ScY4MT2TLxOz/fQ/kPQXDGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDmhnPD8CBQj49/sEXCnd4jkgaij2+VN7P6tvue5rYn2GFTAnouJe3T+0oEUOHKBJkzefePGpcJthlQKJ7CicSgGwPVM0+JiMB+FCCBmJnjxq4sP6cMRYGMvOAG/ue+rMDftnJN6WHWEW1efSNODsgjhw7kzMseVThut2x7wJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DpY0Ea+W; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5943d20f352so2882748e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762759665; x=1763364465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPGUWrjgAY/FIkzGZIG2ScY4MT2TLxOz/fQ/kPQXDGI=;
        b=DpY0Ea+WknelsEsJTjGU+Deyl279mDdk9bsQf52d5Q9v2elpN22bM3p6V+3KbWGJec
         7doU7AsAjWt+ZWbbm8bPkf7pTbhXtrgb6j5sA3nijuagpHKw19PNOdf290AEb9CcWBGF
         qjAsQJHlDj2swJFrXcahuFq9kIcytKZ+sSn0eo23vOYjr6Z5MCOmLorK5iYrhG+pOMs/
         aD+3lyhH3PKnSK9uEbhlwDGoChE5cWZwbj90Q3UgjjbtDHvCLJ3/Ts8gM2xhltLHEs/D
         PiqR3pCXDaA4ij2Rug7M3ndbhytqbQVX/eaa7vyB09Us3gUC21NPce2URN2ApBKnOSiE
         89fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762759665; x=1763364465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPGUWrjgAY/FIkzGZIG2ScY4MT2TLxOz/fQ/kPQXDGI=;
        b=kF2ZDJsc5Vfjdk1c/NB8fJ1lT4Rav83UKTeHnX6DCzdJ7/AkgdZVzU+udgiBQNjwyt
         XvpXKdoltv0OUmPzxAfubM0DI3IUIp4BOoAAmt8m8S9PN0aVriJQQPZtrf2LwJbxFixP
         OV0/p09CHgk+PP2EfGQnvqvE3bNfkCQKkDY16oscAgr7HyAT7dtBdZ7zXWU11l87R8oW
         3QTbHZjWYBHehF3zCtKwH7qTCYBhZM+16VCymFwJXqAkFU/Q24rzNCq4V3NcVox4yfah
         UnzAJCW87H+d3NJXJNXBGInMW67b4HMGP8BXgVblv/kHvQGJVEShsjCpsiJcfQTJDHgv
         z8bg==
X-Forwarded-Encrypted: i=1; AJvYcCUPFOdu8WQ5wd0+WIp5BYYd+hor3gE1jMZDdET+Lkl68ReEDEEW4JxM0pCEqRz58Gg1yEiL6Ptt6AL+Osg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmwnHpRv8SMdLV8yU7r1fbg1feVH9vhyREWFZQch5UQevHxJF
	sziG820xQr+9xA4QZ2SwxR9fdcmp9+c9MVgzl1lx85DU3rrYfHFlweI17i5wlr1fIWeKJLJq0Ir
	Bq7Q9JfmtkxczNipyHWACDDTO3Eg6+d9OTWeDyS7P8A==
X-Gm-Gg: ASbGncsfkbEpOCWWk6Mbba9sw52Eqd4ZdUfLXAh1YzEXrlupfnOQ6d7PL6j7gVIOYQ5
	oQgWWazepHelyF+sKJbre3SUwTPh7cXpx/X//p/etN2L06mhJUQH3EqKhVh7PExIVUm8t8mUBjn
	DzU6oBmTNOfriUIxbhciSrojO0sZVttojCzIcxjT49kutEsIIVdmJpmJL0AP0beCELuJ7Q1CKMd
	H4rXq3tK6Tse95i4jf2hmx2TcrZdLPG7Om3eibvTL3UfBJth4rfjRXFplvnMlSY7KdXung=
X-Google-Smtp-Source: AGHT+IGAgYRHu9qSnW5LSbcNhvv0xfqts/uNRtJg7TapuKfHRukkaL6drJ2+liyQxhPLIOlpQDIO3GNtB5opgS/fuxE=
X-Received: by 2002:a05:6512:2345:b0:594:2df2:84b6 with SMTP id
 2adb3069b0e04-5945f1671ebmr1852916e87.18.1762759665539; Sun, 09 Nov 2025
 23:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022021149.1771168-1-huangchenghai2@huawei.com> <20251022021149.1771168-3-huangchenghai2@huawei.com>
In-Reply-To: <20251022021149.1771168-3-huangchenghai2@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 10 Nov 2025 15:27:34 +0800
X-Gm-Features: AWmQ_bktQciM64p6Jqcdun8oVFww5db_re0mag7ttU9X3A6qMWh7pofHt-DAGg0
Message-ID: <CABQgh9FZRo=3DyuL29msbtc-=YpPVfuRzBLMWJk4s4UJgcJ-9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] uacce: fix isolate sysfs check condition
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: gregkh@linuxfoundation.org, wangzhou1@hisilicon.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	fanghao11@huawei.com, shenyang39@huawei.com, liulongfang@huawei.com, 
	qianweili@huawei.com, linwenkai6@hisilicon.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 10:11, Chenghai Huang <huangchenghai2@huawei.com> wrote:
>
> uacce supports the device isolation feature. If the driver
> implements the isolate_err_threshold_read and
> isolate_err_threshold_write callback functions, uacce will create
> sysfs files now. Users can read and configure the isolation policy
> through sysfs. Currently, sysfs files are created as long as either
> isolate_err_threshold_read or isolate_err_threshold_write callback
> functions are present.
>
> However, accessing a non-existent callback function may cause the
> system to crash. Therefore, add checks before calling the
> corresponding ops.
>
> Fixes: e3e289fbc0b5 ("uacce: supports device isolation feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks

