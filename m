Return-Path: <linux-kernel+bounces-847493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C22BCAFB3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CE204F44AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC2E2820B2;
	Thu,  9 Oct 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq/vsvMp"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336223E347
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046670; cv=none; b=LthUDT/bOtjHspYjgZub3UQiolina03Fhp/PX/HLYsrxqIAc5TSZjSIg4cIwxM5e934cJp2hSXRAcnfc7AG9TU/9f4/PWdYgZL2iISm5ieRMEOZHlim59zP9+39WOxQAImJWZyOz1U+GfhSRkZkgQJwNcJs2Yd+4cqTEJCLpd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046670; c=relaxed/simple;
	bh=bRJLgzASZkxsHD9yucWsO4pgwja4xNp2lEofLHTPNY0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iNz0LSdJEk64uih0zGiAvYxnjKg1p57uZ3EYBf5NUifghqibddDaTQ0A2CFnl35fkgbTswGtf0NSBZ5DfVTq1dNniJ7DJJ6ZStWyT/3Q8SaRN5Eq7UYqKpa1lzVXmM1CuEpAUxrQnHCAPFTb7U4GXqbHfyp+dYb9ivQfL2E3NGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq/vsvMp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-58b025fce96so1263531e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760046667; x=1760651467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i+T2TUA/YA7vzyCSLuPyTAxJgDFydNPLkjp9OYlGnkg=;
        b=Oq/vsvMptHYfLGGUVXC/+X8VqgdjePAyOJUwY8cg1WlfjNcrfa0vtgsHgA65DhBUVx
         fjFcV6hqL1uJMT9p8a/yik9uOeFSYVEFSTOvOZQzHvZrxPNbd+c3j5hgMtlyRry+igGs
         bEKTULKnnpWMcRM92fwB075ZcZbQRAYnl407aseT3OnMBmTvLvDIh/pPlcWPC5iQup6x
         vhh9Uz5UNYs3CcgtINpIVopUBfYRSSEBTatog8C7nfD5MlxRHLP+LW1SxluIoWnUamu7
         YoPlOaN9vqTxPi6oD6eVgb4f9+fYgXqvqLqrW7XPEzamsDB+BKv0nCiviPlEQZsJYwvP
         uXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760046667; x=1760651467;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+T2TUA/YA7vzyCSLuPyTAxJgDFydNPLkjp9OYlGnkg=;
        b=ITQtRwqd3oBL1yBCObcBQcDconOyrc+dX+WEMOLjisQik7A2xTVy1LKsk+So25UFtj
         pvQqs0uf8bErRhaI3imfDRTbu46ZLzZpcHkEjK41JVu7Pi8C+bKYFm+j0rsTd5yPU1aG
         DNr2dyCQBtPIU2k/DEX5svzxfXDUDkn4KOxDrIH5FhsRq9Tx8QBPAZM/pTHU5djejgCP
         o8o4CDRkmASTE6dOfTBkp8VT338hPCmNaxFknaoiF3WLOAX2E+ohKQwzZwtgC5PRqya4
         d1gm9jq1z3/YlP+lAVzC0fnRCo47JBCYeZRWJfzomksyUAHBoW6b5fQLPqS1C0PAXXux
         /V0g==
X-Gm-Message-State: AOJu0YxOdYpwqEf2nI3G+e/gdwAiwXRCfycAQVXLOIn4I6BwKhU9pns/
	nCmzY7Fr7frRQrnLCcmUmMgMSdwwWyYyg3Hoxg+MGrYkrAlfFSfjGCuf
X-Gm-Gg: ASbGncskCI2S5O/paRpo9f1Mo6F0zUDpjoVjOo18kshg0ND+cf6RbKt+RCJxSGiMw98
	whgdwQaku8Q/ZqVO0/NuK2puZ9qlEDdS+wttKOc2TAa6ythG62NWm/7aUaFLhPJj4WYkOO7Qb8+
	dPGcr6sgVqKWZlK8XYmYzIODEKjVB2Ur6Wp8NssAXci87MDldOorKpGYJLymilJb1JnqDNWNXmU
	z/WElDEsb28mJi9XvVtkkKVxQSkKzhEzdRhax3Kh4KUQ7LSYd+yerA8qT4Nb7EnfUGYW+rHyVbc
	Qw00EupuB7/VR89s4w8vw/z60Al9wswmLah2da94EWVIp4bEDwkXUI1T4hAbVz4zde+q1BL+pNu
	rRinRX/uhX7hUQ4Y4vdLoHxy+FZLrvfBdzBxWvVQr2o6XLRtMlA==
X-Google-Smtp-Source: AGHT+IGOzq8mc+hAnsX+GOGK6lb+4NpCrJZZuN3Zlizup+gA/ejrW1Ds+D58PXWcyCAwIaHcTuQRMw==
X-Received: by 2002:a05:6512:2347:b0:571:be21:4cf3 with SMTP id 2adb3069b0e04-5906d89ec68mr2242695e87.25.1760046666936;
        Thu, 09 Oct 2025 14:51:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088563bcasm210614e87.67.2025.10.09.14.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:51:06 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Russell King <linux@armlinux.org.uk>,
  Ulf Hansson <ulf.hansson@linaro.org>,  Shawn Guo <shawnguo@kernel.org>,
  "Rob Herring (Arm)" <robh@kernel.org>,  Angelo Dureghello
 <angelo@kernel-space.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<87zfa016bd.fsf@osv.gnss.ru>
	<CAOMZO5AFer_Yy20fqD9oVSNVPR2ZvvwYbrkSuj7eFgS_uMJC3A@mail.gmail.com>
	<87v7ko11iw.fsf@osv.gnss.ru>
	<CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
Date: Fri, 10 Oct 2025 00:51:05 +0300
In-Reply-To: <CAOMZO5C0=vy6aABa6PGrD2iWBBRQ==LfpnRg3BTh_yTSn3vHcA@mail.gmail.com>
	(Fabio Estevam's message of "Thu, 9 Oct 2025 14:26:46 -0300")
Message-ID: <87plav2186.fsf@osv.gnss.ru>
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

> On Thu, Oct 9, 2025 at 1:30 PM Sergey Organov <sorganov@gmail.com> wrote:
>
>> Uhh... U-Boot is very old and is heavily modified anyway. I figure our
>> local history starts at:
>>
>> rel_imx_4.1.33_7ulp_beta
>
> I attempted to build a U-Boot from this branch for the imx6sx-sdb
> board, but it failed to compile with recent compilers.
>
> If you send me a U-Boot binary for imx6sx-sdb from this branch
> off-list, I can give it a try here.

I fail to figure how to build it for imx6sx-sdb:

$ git branch -a --contains rel_imx_4.1.33_7ulp_beta
  remotes/vendor/imx_v2016.03_4.1.33_7ulp_beta
$ git co imx_v2016.03_4.1.33_7ulp_beta
branch 'imx_v2016.03_4.1.33_7ulp_beta' set up to track 'vendor/imx_v2016.03_4.1.33_7ulp_beta'.
Switched to a new branch 'imx_v2016.03_4.1.33_7ulp_beta'
$ cd configs
$ ls *imx*
imx31_phycore_defconfig      picosom-imx6ul-qspi_defconfig
imx31_phycore_eet_defconfig  picosom-imx6ul_defconfig
$

What defconfig did you use?

-- Sergey Organov

