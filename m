Return-Path: <linux-kernel+bounces-845374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A29BC49CF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C33F4F1868
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2662F7AA0;
	Wed,  8 Oct 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+yyf1c5"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDA25A2BF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924026; cv=none; b=Z2KKvKEYk9NIjNrn9Nhg+FA5aUY4jsklM2Z8gsdRwwJOvYDlzlc0rNMbIvEnAnDHLs0maOckQi8QIEiFUEahlPjlaWvXNgde6+U2S5HR2lBOd/GHHvTlO3bbvqptE/mLxKxTE2tnQn34O1M8BahNoOyUAb9wKv8ZCzrv8ssuvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924026; c=relaxed/simple;
	bh=QAaXwnrxU+DnZug9YvxAxePg+Hr+SBVv0b13M5xwyb4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIoGkyKpD8fRTrLYfCeZyXX/bZptVLKkzAiBF2QQLYh5xmh3fbBLiHst1Y7Bk3cwMIO3ZpWBvphMSfrV2cfn/YTQNEDGAycOoB498na+QX8MIpRktah8MNEoyUrs78IJ0jH/42yPNd/s+y5Q52WI5Qzu0WoGqPIlHuBiDVeSZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+yyf1c5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so1060810166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759924023; x=1760528823; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QAaXwnrxU+DnZug9YvxAxePg+Hr+SBVv0b13M5xwyb4=;
        b=i+yyf1c53uiV7/BGFY5A+hpPKFUrbyCPfpohaTeQzp9AOu8qK48BZPgw9kw3RtZO50
         YaNEy8FkS/8HTnxOjxKQ0xUJr/AiXKuU/EMq4BQfix5hp8i0AxQmsRNK05RUZGQGEg7B
         9G/j1a5AP+WeVfjFZsul2maUUC9S7MFRlC5t4Q6BdmFMoqALBgbr1r8en7+TvEnpXKwB
         kL3zvgTJ8RPN8dPKE25k76jzs1uSp2CjpopB5L5eCQdm58xUkOrYDayloJ9T5KPUclmX
         sS/uvjhHq/mEIjTeUkpxbAaRXRTinpvCupSzureMq/UeZsHHy5EliM/7VZfhUfgIviHM
         VFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924023; x=1760528823;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAaXwnrxU+DnZug9YvxAxePg+Hr+SBVv0b13M5xwyb4=;
        b=n0p9b7R3BuPZ5HdSYtb3o8AoeQ1/Ij6LFGDbml5byOJ34cZUU97rL2dJk4C254sxR6
         QxLjRuWcfcPlH79KrC0jTco/UfrUOj7HfuXwa+Qp9NJYmVzvOtkIDJZihCUjn6d7UKLA
         6Gy1aAAwHz1v9C3h3P7ezzLUsbiOjJs9cf5270y0aC5n4KmCYNUn4Oh4r8TOTzpVDnSa
         tf+Kyp9YCNt1FwUZkRqP58WKhrJRsKQMoxNoKor3/p4o4pGd/ly8I6Gk4Yyyzd7bySBG
         JI3eudnyu3VvR9Q2A3jIGNjCfnPuNx7Wf5ayHvtcDxKnsr7RVlHt/AehjNh4NkpY6dkK
         63yQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5HJ5j4W8yEszMKcj6Y7tJ/ErqsQWWqeyDr5Uv/DjxjnWHnKi7sA6LO8oxwfOZDa1iL/Cy+NjfrMkvzYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFvUWcby7sv8xqt5MaCUUGuT7B8TJoGZKNr38wPV5NT0k3Mt1G
	bkuzvoUn0diCFqsxWr1bJkibPP9trhXUvbdKeRlBdtb7pzVMjNoe8Lgb
X-Gm-Gg: ASbGnctacnWIbSjFxLj/OTipqJkb2/RNEWAT2kVil+NtLSdITpd5nW5l/WhzkOxbJVV
	+yPT/uqzXUNgP+WqkvBwdv723kae6bOsORZ83fJqnCYiaLm2CZPv+5YdhfGf9p8B+S8RpJRr2g7
	t+TTEISzpmdirPpNorRSMBgX1ThZ3IsgP0TUZzWzqv2j+Fzvnw7iWzeDYApbvZCwhVHm7Nlqj6c
	83ysETZ8treg8c2PWLCNd3wHYn/w1e7cqUX5srBpUp09C0bPuZgz09EVxe0FoizmBakA3vx1hVw
	jU5OxyHFQpX3/pNaPvzopnj2nR5YzGvAvyqSOm9u5BmrGxYMW1mGyekfF8DmPjkK5+RCYk9uC7q
	I9wfbKTGycaDPTMhqdRkwMlYbQLInwN5Xq1WioNThDm0xpBcXTA==
X-Google-Smtp-Source: AGHT+IHGB7nZFykLvMY4WwnMOJdISDTd3LpUbuJxhjfQTUQu94888oFE7TL8PefSeJedVtV9n5C9IA==
X-Received: by 2002:a17:907:7e82:b0:b41:c892:2c6e with SMTP id a640c23a62f3a-b50ac7e6c8emr358343966b.43.1759924022756;
        Wed, 08 Oct 2025 04:47:02 -0700 (PDT)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b37bsm1681204166b.53.2025.10.08.04.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 04:47:02 -0700 (PDT)
Message-ID: <5f12fdaaa49aad21403a0a9b96d2b8b3a6d3ca1e.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver
 for UFS devices
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <Avri.Altman@sandisk.com>, "avri.altman@wdc.com"
 <avri.altman@wdc.com>, "bvanassche@acm.org" <bvanassche@acm.org>, 
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "jejb@linux.ibm.com"
 <jejb@linux.ibm.com>,  "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "can.guo@oss.qualcomm.com"
 <can.guo@oss.qualcomm.com>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>,  "beanhuo@micron.com" <beanhuo@micron.com>,
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 08 Oct 2025 13:47:00 +0200
In-Reply-To: <PH7PR16MB6196ADF912182709D465970DE5E6A@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20251001060805.26462-1-beanhuo@iokpp.de>
	 <20251001060805.26462-4-beanhuo@iokpp.de>
	 <PH7PR16MB6196ADF912182709D465970DE5E6A@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 10:06 +0000, Avri Altman wrote:
> > From: Bean Huo <beanhuo@micron.com>
> >=20
> > This patch adds OP-TEE based RPMB support for UFS devices. This enables
> > secure RPMB operations on UFS devices through OP-TEE, providing the sam=
e
> > functionality available for eMMC devices and extending kernel-based sec=
ure
> > storage support to UFS-based systems.
> >=20
> > Benefits of OP-TEE based RPMB implementation:
> > - Eliminates dependency on userspace supplicant for RPMB access
> > - Enables early boot secure storage access (e.g., fTPM, secure UEFI
> > variables)
> > - Provides kernel-level RPMB access as soon as UFS driver is initialize=
d
> > - Removes complex initramfs dependencies and boot ordering requirements
> > - Ensures reliable and deterministic secure storage operations
> > - Supports both built-in and modular fTPM configurations
> >=20
> > Co-developed-by: Can Guo <can.guo@oss.qualcomm.com>
> > Signed-off-by: Can Guo <can.guo@oss.qualcomm.com>
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>
>=20
> Nit: Would it make sense to simplify things, e.g. :
> Instead of struct list_head rpmbs;
> Use:
> struct ufs_rpmb_dev *rpmbs[4];


Hi Avri,=20

I am working on the next version, seems we should keep struct list_head rpm=
bs.=20

On the hot path, runtime RPMB I/O operations use dev_get_drvdata(dev) to ge=
t the
device pointer directly, never searching through hba->rpmbs. Array's O(1) d=
irect
access advantage is therefore irrelevant. and the list is only accessed dur=
ing
probe/remove (one-time operations at boot/shutdown) where performance
differences are negligible. The list iterates only over active regions with=
out
NULL checks, while an array requires checking all 4 slots.

List uses 16 bytes per active region, array uses 32 bytes (4 =C3=97 8-byte =
pointers)
regardless of how many regions are active, most of UFS devices only enabled=
 1-2
RPMB regions, making the list more memory-efficient, right?


how do you think?

Kind regards,
Bean




