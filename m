Return-Path: <linux-kernel+bounces-723063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A82AFE250
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6295C7A217E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AFC23814D;
	Wed,  9 Jul 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qutqCp4Y"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2577239E9E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049000; cv=none; b=a2H9lVNiqPPINZ6/rcamjOxUfV9qiqakMsz8eP5XjHq/GalRbnNAPLk3tZAkg9hdiaRBV1n2ox2fCZYvJzMAQGyOh+Kd9S7BgqiA+Sx+ltbfID/6s8VAC3Dai331dJuHYUhiOlkKaVxpQ523lukynsFeXkWl9i/fQWhDZ6MJNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049000; c=relaxed/simple;
	bh=ESjLO9Zhed1cl1ztCJTIT/ZnAfHW/V/nC+V20hNxkao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UCuA47JE0i5mfNXiNWNB9/ptjjA/fvGlhyNAGVLSOTv/I6pJ7KP8UZm4PpNbFZY7b5GPESwoq6ydME5c7GfqQx+udYI0HoVqaUWQGl2/MaC0lGdlmiQ/1add1Qughl68TAlDXg/FlPK7+Mgs42MOEx7bKFsn284mt2M5bxXmmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qutqCp4Y; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a588da60dfso3596291f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752048996; x=1752653796; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqD2PBdEEtL61TcBWPiwuwUSzaM44PpR+jAvOgLtSbk=;
        b=qutqCp4YNIVQ4o1+wupPwMofWYT+EXyKYvFa7QnZMk3/Bl0IYmfcNaYsxx/dMvCw6y
         IFPXWTd3LxBtUMix6s78ux8wblxBOEJNEaiJKF02JHa8jz0O8STeKsR645nI3+D60IWD
         /ExHBUaxN4FBvi2EKaetf6yd5jC2sIW76nd9RO5pU7gYLl6r43aDzOZIU/YL96MBYevA
         d/bcefMpx2jfWI9Va8MRGTukJkWj4VbWpy2pHNwiRrKITHeH2RHwssLOORMfvIEifMuI
         GELU9Aqg45O+ztDmI677xB+XY6n27D9GuXG4ugmjUrZ5CAmnneE8eKEkxor1BK+zJdHh
         Wugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048996; x=1752653796;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqD2PBdEEtL61TcBWPiwuwUSzaM44PpR+jAvOgLtSbk=;
        b=FDWE3CpRPgAdsW2ML7kqq5zWUFsnYI8nwy3zMUMPhgZ8ukXD+T5dGjnR9TNMzbXTN3
         kbKCgpWkbzL6Wg6+4/LFZWLpS1rPLwYT8Id0W5UxOWlMEcgJOwKLufahpvzEd3gzoJJS
         R906V4S7TaGDwzErJYqSMbcPDLaMmYPRmk2j/5ErsRa+7FYTRZWnCnVYa4ydSeAKZvGD
         LYWcVYP4TJ3zXmZ7IiBb1dzd5mY+chj8hXW2kX2oNqJk6U1C2BThvWZRqiNyZe58zbEd
         jkX18+noMDu84GblLFi9jo5vmSR15amDL0ZNGMYn+kQV4ttSDyEBEjVxaAxPscFLGLKm
         liNA==
X-Forwarded-Encrypted: i=1; AJvYcCXgX3DECHuJdL3e317hfpYmDYMPjbnLQjeupFn5S6z/fMR3SDoAIh2vHMvItQaex4zc9tZtsFGIqihQSLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrW5TYup6bIdwFh7u1dWBeR9J8zRvTdbOVv9BcWU7G+tDdLbJ
	pabHQYfbDXQAsGq/+z3NquB6o9OOnjGgW6VeSV2TQ5BRp4Nvm6osGO5FkiNWMc4mVR8=
X-Gm-Gg: ASbGncsY3jfoFVCUGxD2BohkEQWnC/FoGa3dRogBvdKhakmeRwK3+qH6XSa8BzglLey
	uZ+/CWmnyqc889Ep4GepQSRa23AfHCljTXtdnTqviineuLxY0LrPSmAmDw9fU77T5NMV8kQO9fA
	TsRz5lmGZ6OzfCVv5Du500Omjjti7Zpg8J54qUTMrPbm46wQ4MGiTUsKez178awgvxnjIJ0HeTm
	Ua2Js3PaGRAMpA9eCJ1vg6c9a1oSt1AYiRVCaiPbxPv+JeEs+i1GQxluzK5UmLHnJgzz4EwESE5
	3DxzWxSnib9L7BE7pBlqVL0+zBMjXnGcMR53BB2TBnXbnjuCSkj8eZ2R8NdcoQ==
X-Google-Smtp-Source: AGHT+IFDWgOyd6TctRhGyDf/BFXl84n44wynt3pzJXN6haPyohv/Z6jjdLJP43b8OIYqGclCOkgE7A==
X-Received: by 2002:a05:6000:2313:b0:3b3:9cb4:43f9 with SMTP id ffacd0b85a97d-3b5e4528344mr1167851f8f.16.1752048995397;
        Wed, 09 Jul 2025 01:16:35 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:6015:b265:edf6:227e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b472259842sm15150123f8f.72.2025.07.09.01.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:16:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  Manivannan Sadhasivam <mani@kernel.org>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  Kishon
 Vijay Abraham I
 <kishon@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  ntb@lists.linux.dev,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: fix MW2 configfs id
In-Reply-To: <aG1a2iy1/2RWd2FX@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Tue, 8 Jul 2025 13:52:26 -0400")
References: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
	<aG1a2iy1/2RWd2FX@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 10:16:34 +0200
Message-ID: <1jh5zlrd7h.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 08 Jul 2025 at 13:52, Frank Li <Frank.li@nxp.com> wrote:

> On Tue, Jul 08, 2025 at 04:49:57PM +0200, Jerome Brunet wrote:
>> The id associated with MW2 configfs entry is wrong.
>> Trying to use MW2 will overwrite the existing BAR setup associated with
>> MW1.
>
> :%s/id/ID
>
> need new line between two paragraph.
>

I'll do the v2 to speed things up but the description looks fine as it is.
The comment looks rather like a personal preference.

> Frank
>>
>> Just put the correct id for MW2 to fix the situation
>>
>> Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> @@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
>>  EPF_NTB_BAR_W(db_bar, BAR_DB)
>>  EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
>>  EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
>> -EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
>> -EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
>> +EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
>> +EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
>>  EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
>>  EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
>>  EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
>>
>> ---
>> base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
>> change-id: 20250708-vntb-mw-fixup-bc30a3e29061
>>
>> Best regards,
>> --
>> Jerome
>>

-- 
Jerome

