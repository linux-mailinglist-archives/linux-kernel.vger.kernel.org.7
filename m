Return-Path: <linux-kernel+bounces-857709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 204D8BE7D03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1F358096D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F12313E27;
	Fri, 17 Oct 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2SuZ1Oj"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B302D877B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692868; cv=none; b=hVLo2HGKVvamxhynruCKiHGeTZWjLsLodX3fc6eVh/YfL7oFlIyrXcHczCAMNjHA8UC+FT5zXqCfNpK5eOlyIalyZH07Ujs2EDbKx62Ypazd73Yf9Jzerm7PIs+KcNFU9D50uufXlzc8jLmMNWE+jCQPyyEexxrRtklIiaTTHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692868; c=relaxed/simple;
	bh=XwbL7/L7C9/nDL2/xmbaFiG9RcBj6a+Cj3r3ADzcpU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1SGj6wlfEdaZt/XfLWY9K2EeShUruA68G41TvD2HlatwySmabINiXk9ITwrR4vsrrUqQRjlL6gH6WEUc2WRd12B8XrN+oz+YV0KnlZRaG7PBlKEtB0OuZypPEUXfz529JD3mpedB63N3R54ovrnLf5L83YcPpxfA8Uc8c08sSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2SuZ1Oj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c1006fdcfso3113653a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760692865; x=1761297665; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XwbL7/L7C9/nDL2/xmbaFiG9RcBj6a+Cj3r3ADzcpU0=;
        b=P2SuZ1Oj6xGm2iA5KKOEpUHCvhMWF5HwqfjfdTnTR5SWrqJB4Ghcf9bbtMzOj889wd
         dyca7uVM2HGaET4428Tlan3dG66XXvcC1QGWpvjtPmLOBUzChA9cH8nQskd9LUpR91AP
         kufkblqFG2uajTg1kjWYz58OPgzeZe2x0EPW/zHSpfvpcp2FU1BpuzIWAWFVvbbZSteN
         HsCflN59L4QbqBtGPIibj1ZwgqmcaBBdHA3QG5Yg9lZ2VDeiXRmkSb5WyiyBWbMAZx2w
         ysodKKjW2vcc5oJCah/fMFfITVLQ3K+UAgCM77BbjBoy2E24JQ8M1LkCoHEcUM4gUasN
         6+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692865; x=1761297665;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwbL7/L7C9/nDL2/xmbaFiG9RcBj6a+Cj3r3ADzcpU0=;
        b=hIukXeHSLiXB1USO+XtePPe7aTL1BhmxPyPoRCKald8dUqBjFZKACKCluvqCbjTzFq
         LSAIFgUy0CDDZiiS1ERkLyJeD07mHn3pL3tCI2Lz8GMtTB2LPzpgTMJUACg9z5Gb3wR6
         4cHijDePBntB9idCZNUc3TpbxnNaVhsbPCX2KOG5Fm9dTxUugtZG3QpbkZAHDta0Cf1u
         2Avksu+reGy6aSblkxmVNAj3aJgm7LazZ0kvjmFTM66AIDzpos6jKWreezxQtN6BOdmx
         zoFf7+tZLQQk/yYLllnOtoqA1L3VQKsuW8kIZXxfNgkhbDsgTrA8STROw3XaMly9lSgn
         V8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVDsrsx3pF5vGsE7+cE5MDVZ1yXn2X23J4WymNtyP0qHnzjxV9BeEZDfyF1L+65AS2SK94Q9qXbQIMFNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzikcJv8CbkMxQUEUiUGNkT8fIwVi3qc9q59zri7QDvlXWMAdlW
	YJazXsLCTrYPgbWOLl8pMXKD8l9b8SXr1OGh01g/dACyEiIIeDxKUZqG
X-Gm-Gg: ASbGncuYjAJfDm3TV2U3BJtvg7S3bnZ/pW9lBoQ2cicBqmGmdZPLIvby4P01SjFeAXx
	9anbhok0x498a/C07CpUDa1K2VTI+Izr4SLApzT7b+8MaAiSXuDQJs1wnR6p2d973BnRpsbSNEK
	CAqRoOk463cLrHwPR1uWJgeXYSxyMjD1AKI3EUV4OG+UdZeY3cgvZybqW8cjpSe+wyypVrLZ0Yx
	axNS6oHm3DrDg/HcglrYrjrfKO4fbGa6xzCQJRMCaBbGHQXiXQfyguDnu5Iz78pUdtdokDOuX9W
	kX+2TIj1m4sftULrzB7liQ0n0RiU2NYjgn5yqUCs++D2VJMb7Fs7gcfqxcWHsQrNHTu+KYqhIYT
	Ai0mRnG1cpcKhb7nOFDUUOnhyEGrLOKZSdF+hgr9fHkcw5sjJlhDdVea07Lcx+YHJqW9KZfDYiA
	tFS2y8vVauL5Gq87gy8WN50ZrpBoHRrdY3eCWKjiqsu1CsjfND21BI7BLgaKfMuQwxIFqVkidNe
	EtdqjjxzmvHxd3wjfmAcLscZiPzQ8mLm2LrOVA0qA==
X-Google-Smtp-Source: AGHT+IE7BCFzUNiw2i4QfZjW5SFw2tnLjupBLrUZan9DS+NtJPOwUeqzaVj412XY3mXWNnoOXTZFIg==
X-Received: by 2002:a05:6402:2681:b0:634:ba7e:f6c8 with SMTP id 4fb4d7f45d1cf-63c1f6d5e1bmr2398533a12.34.1760692864549;
        Fri, 17 Oct 2025 02:21:04 -0700 (PDT)
Received: from p200300c5871d09695ffbc7296f39d3ed.dip0.t-ipconnect.de (p200300c5871d09695ffbc7296f39d3ed.dip0.t-ipconnect.de. [2003:c5:871d:969:5ffb:c729:6f39:d3ed])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c0eb3a235sm3458175a12.30.2025.10.17.02.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:21:04 -0700 (PDT)
Message-ID: <8dd21b9be370998277cdc014d7e5d4d333adf575.camel@gmail.com>
Subject: Re: [PATCH v4 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver
 for UFS devices
From: Bean Huo <huobean@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel test robot <lkp@intel.com>, avri.altman@wdc.com, 
 avri.altman@sandisk.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
 jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
 beanhuo@micron.com, jens.wiklander@linaro.org,
 oe-kbuild-all@lists.linux.dev,  linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 11:21:02 +0200
In-Reply-To: <CAPDyKFrsMxyD5ASGmsQ8658eBR0vHOSUqJ4axuSpAXuue6d5Uw@mail.gmail.com>
References: <20251008201920.89575-4-beanhuo@iokpp.de>
	 <202510100521.pnAPqTFK-lkp@intel.com>
	 <eccb18abe33299edde64f96e0c3de88c4183cb78.camel@gmail.com>
	 <CAPDyKFrsMxyD5ASGmsQ8658eBR0vHOSUqJ4axuSpAXuue6d5Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 11:11 +0200, Ulf Hansson wrote:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=
=3Dnext
> >=20
> >=20
> > do I need to add this queued patch for scsi tree as well?
>=20
> I have just sent the patch to Linus to get included in rc2. Sorry, I
> failed to send it for rc1.
>=20
> That said, if you re-spin a version of the series that is based on rc2
> on Monday that should work, I think.
>=20

Thanks, I=E2=80=99ll send the updated version to address the unique device =
ID concern.


Kind regards,
Bean


