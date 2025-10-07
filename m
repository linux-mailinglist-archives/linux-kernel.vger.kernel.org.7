Return-Path: <linux-kernel+bounces-844178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD99BC13B6
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0163BA1AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EFD2D8789;
	Tue,  7 Oct 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWRNj0aD"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6C7483
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836957; cv=none; b=SwNOE7ruILoru1lToU6nXAIabTa23i1fFfmseSHwnC+ls5TG1pd44JceQh/+97j6YBDk168KXEgrn+DImTaQ8FTtbF29oEHDECvi0tedWQ5QSt9d5v92iXY7YS44fa1W0vz12ggP0ZN+yhzKJwHsg9/UGxCy5rMtzy0DXlxQ8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836957; c=relaxed/simple;
	bh=G5J/uuNR2+rK2siseRS9pFAJo3DSv21wsSkxUqGR92A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VujwDvg64k8frJ2TBeni3kCQH0dvGnLn9tNQKMNlB22YDhAcdZ/qhRSOpDAPlPcS5TQzu89RsZjkhH6fD+1/3NNBPXM/xDNweOhy4FHrj59WpIBxvmwNNS4bsWhMnyS+mpiMxd4l/h47bAXiGG73o6WriWj5uiIQ50sxz/ydIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWRNj0aD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-361d175c97fso59637321fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759836954; x=1760441754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G5J/uuNR2+rK2siseRS9pFAJo3DSv21wsSkxUqGR92A=;
        b=bWRNj0aD6Kepid14ZteUg+MEQI2ZlNj1bR6jA14TCE2w3uwtJw6bDzwWHynCBeMiw7
         wd323KIV2uB/D/Os8Y6zRCcRgcosIafOGdyZb8jgg0dDEl0XZJ7Rpcqex2XNxtxEVskO
         +yyv8IPoPiiXGUhUADfwf5qnalhtQicVqpGXwSIupHh1owV8KAf/r2jUO8CK4nkTuAPo
         6o3zMCb9NndAqnNjvX8sBHk1RwH+6II7s6smbDpNJUChhfiZMepzbpUaKNDmIeNg4A/p
         f3RsG7oBjv31VZxlUJIZNOGXiMQnAJeBB7LSOvEm75U3i42yJ3w+p7AbVHkdp0u3tYHW
         5utQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759836954; x=1760441754;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5J/uuNR2+rK2siseRS9pFAJo3DSv21wsSkxUqGR92A=;
        b=Phzd8n7XCBqYcrgnPS3ggQ9zliJq2XLVak/Zx811mLgfdorfG8QpFqwRYMSZxIPKRp
         wJZZS5OxEgpHpIbRucoo7+LKQjJ/+iy/ZuCwCNh57cMmP4uIC2aQPfF1RxxmNNpLmb5s
         1JQMABY9mv5P6/dlVfzrx1todahLRakL7P0u9YUNDNb5XqedxHwelCDUhKXX+MkZAJx+
         LEhF0JeZ2K7sM4ZsDwbtDxxY8jV8Ep76NSCR/LcaSJF2UwsYEe+w/Ec4QFIZTsycQLaQ
         ch4F9S9WZzxpU8KF2o0D9/F1kbke3MxZVo7WHwTfVwmVrtzXBCoMjJBkXs5JMn8OHbwv
         2p/g==
X-Gm-Message-State: AOJu0YzkjHvLcs1fSm2q53YmIlwFfLu2Bz5jG7hSf1NVzynQ62Pfn2ZJ
	mOjG9vzbXOBaoHWALt5FNLsqXsDpyzGQfLj8rKYQIdejLVYJNgttjVTn
X-Gm-Gg: ASbGncs+xTyqQOg3hdBGVWnigGssPwvb5wqD75l261iVzPAngUdxMKgSWHi8nIGSE/i
	oSzmB9cOtM9pNUfYSuMBsxyAC1X7qjrHqjdr4ykp0KhSCUwbi1prLJkO/HdeaqFxQao3+OKC7zZ
	klZSooiDii0yV/1eBcB5twd9broBRX9MBo4mE5uu5WussFSIIL8rlXbAgn5SsmwOuHNXsdAHOs+
	0ilGdRY8Qj5UdIhmjQb2mUTkdCC/sRxTCzDgRvZcfI2p+W4nQ71tHvCmsFXN3wOlBKoxP2E2FYj
	p9QPw/h4aMHvOZfaeBHZKrA8SR8NGGrZ2qN40d38eocGGoI06xgHwqaGEA/6zQCSLG0JkY0MXH/
	JyHMgWGDFsLuVxF2OodzZbyirLMa2Eo8wZYjbsrKK9BTboIhihw==
X-Google-Smtp-Source: AGHT+IEPyhdLup/kyW5/ExkXYf1rPrMSmeG756snEMy2+sQmP6Xwft4GlyZsIzLw7k67lp+rlI3oNg==
X-Received: by 2002:a2e:a901:0:b0:372:9c25:7a94 with SMTP id 38308e7fff4ca-374c3861533mr40128891fa.41.1759836953471;
        Tue, 07 Oct 2025 04:35:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f39fc905sm9065021fa.20.2025.10.07.04.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:35:53 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Ulf Hansson <ulf.hansson@linaro.org>,
  Shawn Guo <shawnguo@kernel.org>,  "Rob Herring (Arm)" <robh@kernel.org>,
  Anson Huang <Anson.Huang@nxp.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
	<87o6qjaiz7.fsf@osv.gnss.ru>
	<CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
	<87jz17afpb.fsf@osv.gnss.ru>
	<CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
Date: Tue, 07 Oct 2025 14:35:52 +0300
In-Reply-To: <CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
	(Fabio Estevam's message of "Mon, 6 Oct 2025 23:05:06 -0300")
Message-ID: <87ldlngd0n.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fabio Estevam <festevam@gmail.com> writes:

> On Mon, Oct 6, 2025 at 6:22 PM Sergey Organov <sorganov@gmail.com> wrote:
>
>> It is built form multiple .dtsi, so I figure I attach the one after
>> pre-processing stage. Please let me know if you'd prefer I rather
>> manually insert all the custom .dtsi into a single .dts, and send that
>> one instead.
>
> This format is hard to follow.
>
> To make things easier for debugging, you could create a minimal board
> dts file with only UART and eMMC nodes to reproduce the problem.
>
> It's not clear to me the relationship between the ANATOP regulators
> and the eMMC power on your board.

Thanks, Fabio! OK, I'll do, re-check, and get back to you.

-- Sergey Organov


