Return-Path: <linux-kernel+bounces-834869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD828BA5ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E496C189EE38
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038CA2D4B66;
	Sat, 27 Sep 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXfEcsDx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B52D47F3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962454; cv=none; b=EqlLYMv08l8iPb7rQt+oHRh43etP7uLNO4ArRDaYxa/qRVqFeyZRq6rvMaDdDBPXWrBtohCj5e56HpTjEUzR5ot8l5iGqImsnybO/UGjxHLUOq93YRA0m5G64D58HoZk+Utvuu6w4ivTMKDQm7ghfZPMNiv50GjuEDtA74VzsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962454; c=relaxed/simple;
	bh=KzguTlN0DVDwQyWaiKD+T6TVR9NBd+VANkU7welrq5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3CpJu9E97qjg7jpR91gvJozLfK5VvIC1lcRt6YOUVleyosfFN8e+8wvP/rYeyB/U+WCUtLC0XbqrO8hLIHWF8d4keR9gvly1MOnkxrYSjFWAON5AyGZDvVN5jzTnXlUO+I+d1TzRtikKpo/vKoUUgDEeVMld8hIFOnfP24WnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXfEcsDx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7a16441so478354866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758962451; x=1759567251; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KzguTlN0DVDwQyWaiKD+T6TVR9NBd+VANkU7welrq5M=;
        b=nXfEcsDxKMSfmnnr5m6/EZOY//0Y0OstJv57LvsG9WnPFJtzLF7EOzW9tSI6NRYZt+
         7Qz8d/6ZJWZpofZkZKF1cPm6OdtZT6MfcxiRyo+/NB+ZtW0agzckQLOa4AGeR0QufYqn
         u3dxGQtFq8LX/ucTL7fgHn5HcVAGdUQxIinjTq4sabWEZCpYweakpVMXzWRqm+SKiIzz
         jh3LdkTxN+15k/hY7vMLJ+ELwYMbRTsNUOnHkou5LbV4mpWbc+YekxEhd+BR0ozxmM1q
         s3ibfxnd6qoOdmzSl4fhdPO2rIUHeV4hC/NeUpY6aysEqVjaoakszkGBW2L4w8r1WKRD
         S+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758962451; x=1759567251;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzguTlN0DVDwQyWaiKD+T6TVR9NBd+VANkU7welrq5M=;
        b=NhF/Rx+zQBOSxZ0XN+Eqj9i0I+Q/+vSWqrLXkUjeS2S7ye5vlgeE5I+KFKSHcL98fs
         NUtP1pMWKjDGFjTzLJU9O/+Wngqmy2UyHEf8YSbwK5UuTedxeu3bZ4zrZWUg6ZBTWUzV
         zt5OIyUZEfYnQqtB0V8tQMOjZwrMaW5y9A7LFQT46K2DecXGQsvZbw+FNeQ5SLxtzGiM
         32/DbxB2oIE/sjyne0ypyzfO6iTdLVVZEn2gKAehUENQSj/EEncnTdm1AYbD1MCX7oeU
         QChwlI/HpZAYQEDDJa7IVm4wdY6cOxjG3D9SqDXZqCv9q514Xq68IRSuE6QKBHcfGgvb
         xipg==
X-Forwarded-Encrypted: i=1; AJvYcCV/oWid7TRZIlMwlR0yt5ySYNZybmRTlNU8Df88Emur388TW1756VADaB5u1Do8lxTuYOKL59SQtSN+UHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TYFbgbQugyNdE/5KkdGRwTGJ9+vGqUlsyjmzpW7oGkA4gp3R
	sqzeIIZjPbpw5/p4hhh7DLq1xtRGFmQ9DXYtx7DJU+rEgfplkfRsq3I2
X-Gm-Gg: ASbGnct/1KQg3XuVuAbWtsChf9neM97lcaX3YePYb/UMnUBkxAaTbJD5HHXnjXhj3Wa
	4sO3Vxt9XwAiERnJvpJS6shjaTAiWtQu0TeHT/Vpzz0zNo0QrlXbSKNRLFbz9fiAQ2+8e4BDyFU
	GKAt6HPWE39Ah4BqxH6oWnoW1UOvINc4qJ9KibU++Tc/+q+Z3/Ha64WwzlKIIKKAiRwAoFfe+pY
	h1dQ6HeOZx8Z0gXloxS2fUO/Xja6BKsrmAGMbIiCaN94AZlZZWzlJoSVHnICTr/UTSWQsX8DqmD
	UcJB705PxsHTuTJ96I0RRIETOv1fgDRgkPOnEoeAAiyElImdVtAv4246XpJryOODL0AY3Yrng/r
	/0EuHtF36sjRhuml9DO4MDHzYbEwrYBudk9IfzwG3paTulAdRqKoRaQw9OZAfyLp53eVPvk1pVh
	/Mzgv2NGBEFJ8Ptfa99XxxKc2SJgr8iX29zdZqYQax3ObTkGkIr5drvjYgleADZoslc+ncsazU
X-Google-Smtp-Source: AGHT+IHPPlIqi4T0deWOBfsYReBj/m14ttoNCIMpmMi0REJRA/BBHe2RNMNkarSZssV1kYS013S9NA==
X-Received: by 2002:a17:907:7244:b0:b07:6538:4dc5 with SMTP id a640c23a62f3a-b34bd93d0edmr1007630466b.64.1758962450674;
        Sat, 27 Sep 2025 01:40:50 -0700 (PDT)
Received: from p200300c5874155a05266ae5ed58ad6cc.dip0.t-ipconnect.de (p200300c5874155a05266ae5ed58ad6cc.dip0.t-ipconnect.de. [2003:c5:8741:55a0:5266:ae5e:d58a:d6cc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35448dfee7sm513147166b.63.2025.09.27.01.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 01:40:50 -0700 (PDT)
Message-ID: <713065cd1b7c9fb08393fab8cb44e3a345a55be1.camel@gmail.com>
Subject: Re: [PATCH v1 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver
 for UFS devices
From: Bean Huo <huobean@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>, avri.altman@wdc.com, 
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	can.guo@oss.qualcomm.com, ulf.hansson@linaro.org, beanhuo@micron.com, 
	jens.wiklander@linaro.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 27 Sep 2025 10:40:49 +0200
In-Reply-To: <b2ed97b4-bfef-4e4b-83ed-a172214e46e8@acm.org>
References: <20250923153906.1751813-1-beanhuo@iokpp.de>
	 <20250923153906.1751813-4-beanhuo@iokpp.de>
	 <b2ed97b4-bfef-4e4b-83ed-a172214e46e8@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 13:27 -0700, Bart Van Assche wrote:
> On 9/23/25 8:39 AM, Bean Huo wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D scsi_execute_cmd(sde=
v, cdb, send ? REQ_OP_DRV_OUT :
> > REQ_OP_DRV_IN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buffer, len,=C2=A0 /*timeout=3D*/30 * HZ, 0,=
 NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret <=3D 0 ? ret : -E=
IO;
>=20
> scsi_execute_cmd() can return a negative value, zero, or a positive
> value. Both negative and positive values should be considered as an
> error.
>=20
> > +MODULE_DESCRIPTION("UFS RPMB integration into the RPMB framework using=
 SCSI
> > Secure In/Out");
>=20
> That's a very long module description ... Can this description be made
> shorter without reducing clarity?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 rpmb_region0_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 rpmb_region1_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 rpmb_region2_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 rpmb_region3_size;
>=20
> Why four separate members instead of an array?
>=20
> Thanks,
>=20
> Bart.

Bart,=20

thanks, we will fix them in next version.

Kind regards,
Bean

