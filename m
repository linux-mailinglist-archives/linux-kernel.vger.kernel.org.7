Return-Path: <linux-kernel+bounces-744937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D846B112C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D866BAC312C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776E92E9ECF;
	Thu, 24 Jul 2025 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jf3umRtK"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5411F4CAC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391120; cv=none; b=qjrFn+Ug+ThTQBifgtrD9O6laGYEuHsBCssYSoCYZiqFFclnMNSOGSlbSaf3fjMY/3GhhhlRn/+veRGlB+tk9BiBF/axNt6HiUWgOGdadBXBojNv/GZQFU4vYxwW3St/GpO3T3qePL43OKQrDIH33Shon1pfq9ZYkDNXAWrcmXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391120; c=relaxed/simple;
	bh=RxP6zQdaR70YQUAliiAkYsrKRCWSUAWmKvfFxROJNm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6hjDysRyAbzdinFXap/Gr1kipSvS8OqNttvVlyRZuxZPfdZNq9VqVa0EBzU5uw2Jx/D7SQrJsZKKFmhgJTuYq4HHZDOakE8mqbYjy/4ZFNXloQElHhBxdFutw/vvP/8pEapcxD9cLmM/uLni6y1fJfCNj7icIIQeHYPnhf4JtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jf3umRtK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab86a29c98so98261cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753391117; x=1753995917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+jPw+Q+nB+FggL5ZzS0C+jGN5ezuxzf8QG/0EUbliU=;
        b=jf3umRtKaFrUHtI9oRI8GARWftTSA1FlogC0ri/P8F56rWuuxhA8pwpE4J6AtFC2/z
         tkzOE2/QMfI3lLxRXGbDOa53yc0LmAId+70fKzjTOBSOlfQrGuOEaswkNSKejUK2/ziC
         sAoxkahiA5UF9sAjerF+3CySnqHIuPi5PuulFOntmFylBFv9ymUyzvjZhvdg6Urg9Oj1
         6oXocHj/Ckvjry4KGdJ0ouRqtNETnZn5SDxtNRLIDlnrxMEfODrOpkRAQC0fBBALd1yg
         6w/5FJywys3ORftKIbPqirWHIV9aR1Nwrk3M1/cigk/mr6NHH8arMRLO0zimWC3lXjIy
         A9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753391117; x=1753995917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+jPw+Q+nB+FggL5ZzS0C+jGN5ezuxzf8QG/0EUbliU=;
        b=eKtXf8f45g/lcCDPPrUdoZZx+qjvjUmFGJQEpK+MIShOBvfTWJK06GN6VYpjtBxMA7
         PTV+dQINDMb1PPIowMerffQrprqeAD/Mk/VB5JqgqvqVMdJWUAmFyZl7+kgFMrXK3BU2
         3klhCnfokH4y8rU50M/xb1lDkMPes1xMSTOB0ctZwAGL9EfQ/U3xuTzOTi6s7eiChB2x
         RATiy719kn3WaXf7sgGVlvvBwfw8hKFw5SJnjav7a01fMIl2Om8Vm0VxFE+yzXsdbvia
         qYeTU9i2kwGGWghBTAd59tc/M9vw5EoZ9HljsPGb+mZsHKgvQ93GmnBd7XCAAlPtYvpw
         2TYw==
X-Forwarded-Encrypted: i=1; AJvYcCWx9PW2HpBNYobqr3xkXLOrgBTy02G4vWAMr/n85tZhnksbtKUjKHfSvp97MqrjjsnPpKg+TysRsO2Pto0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qlMBsLPwm+FnArB/kRV4u1Vne8XJfH317xi5YLzsK0KD9pHm
	FSA9SkyK/D9VhZkv07MeR4A9CHX0kpUhVHe/GXPuWgGIrF1G/K1ZlirU/8avXRfJYlSQL1ku8r2
	sOKz/TzK0QshF3iwDjDgIkZuYNvGyAnTlCfP1yqCVYPyltLwKQQ6W4G97vtBKUPr6
X-Gm-Gg: ASbGncsP33n4TDjjaFap8KRtt27KXduMonP/bivgjhRYsnwAjFOLRfeFZdw+OTtF3yV
	HJyIp6h1ERHQvczdmuYuYjqEl7WNPD03LcVxHsOtddejl5/QhjCx8dwJrNXxYW8MsF/XqOCMmmO
	RAYZL1iAlx4/AU8oR+mCOVnLOV1EsqV+ioObzvcdwOevHh6M/Ob52soHOVTfGBk+odVmcNQoIr6
	IM5Fa7JG+yRUUU7CA5PzAQ1J/5gyx0hV3w=
X-Google-Smtp-Source: AGHT+IFgtODzATiWfxFMkF+cB0CCKx9TAdxB+J36KCzgYr+CrQ9mMY1lomvmkNaYizbbCRci5X34CW5Er9q25AOZSR8=
X-Received: by 2002:a05:622a:198d:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4ae89e62470mr1157481cf.6.1753391116413; Thu, 24 Jul 2025
 14:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724203805.93944-1-salomondush@google.com> <ad9e3921-43ed-4abd-acce-ce46d57f32c8@acm.org>
In-Reply-To: <ad9e3921-43ed-4abd-acce-ce46d57f32c8@acm.org>
From: Salomon Dushimirimana <salomondush@google.com>
Date: Thu, 24 Jul 2025 14:05:05 -0700
X-Gm-Features: Ac12FXyaaMFJE7Zv10L5w3pTul2f926wrozl-RuIkD6s3_nVk3bz_zivl1J9GqE
Message-ID: <CAPE3x153br+UdtWYnxdtAX7hz2OwKYovQeWdeOCWvicTxDayeQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: fix sd shutdown to issue START STOP UNIT
 command appropriately
To: Bart Van Assche <bvanassche@acm.org>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishakha Channapattan <vishakhavc@google.com>, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bart,

Thanks for the timely feedback! I also thought that the
manage_system_start_stop flag is more appropriate.

But I wasn't sure why the commit mentioned in the description removed
the manage_system_start_stop from ata_scsi_dev_config() function in
the first place. So other candidates for a fix were:
1. Adding the setting of the manage_system_start_stop flag back to
ata_scsi_dev_config()
2. Configuring our various drivers to individually enable the
manage_system_start_stop flag (less preferable)

If there was no good reason to remove setting the flag, we can go with
option 1.

Thanks,

On Thu, Jul 24, 2025 at 1:46=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 7/24/25 1:38 PM, Salomon Dushimirimana wrote:
> > Commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
> > manage_system_start_stop") enabled libata EH to manage device power mod=
e
> > trasitions for system suspend/resume and removed the flag from
> > ata_scsi_dev_config. However, since the sd_shutdown() function still
> > relies on the manage_system_start_stop flag, a spin-down command is not
> > issued to the disk with command "echo 1 > /sys/block/sdb/device/delete"
> >
> > sd_shutdown() can be called for both system/runtime start stop
> > operations, so utilize the manage_run_time_start_stop flag set in the
> > ata_scsi_dev_config and issue a spin-down command during disk removal
> > when the system is running. This is in addition to when the system is
> > powering off and manage_shutdown flag is set. The
> > manage_system_start_stop flag will still be used for drivers that still
> > set the flag.
> >
> > Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
> > ---
> >   drivers/scsi/sd.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index eeaa6af294b81..282000c761f8e 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -4173,7 +4173,9 @@ static void sd_shutdown(struct device *dev)
> >       if ((system_state !=3D SYSTEM_RESTART &&
> >            sdkp->device->manage_system_start_stop) ||
> >           (system_state =3D=3D SYSTEM_POWER_OFF &&
> > -          sdkp->device->manage_shutdown)) {
> > +          sdkp->device->manage_shutdown) ||
> > +         (system_state =3D=3D SYSTEM_RUNNING &&
> > +          sdkp->device->manage_runtime_start_stop)) {
> >               sd_printk(KERN_NOTICE, sdkp, "Stopping disk\n");
> >               sd_start_stop_device(sdkp, 0);
> >       }
>
> A Fixes: tag is missing.
>
> manage_runtime_start_stop is for runtime power management.
> /sys/block/*/device/delete is not related to runtime power management.
> Isn't manage_system_start_stop more appropriate here than
> manage_runtime_start_stop? Shouldn't sd_shutdown() calls triggered by
> writing into /sys/block/*/device/delete already be covered by this
> test: system_state !=3D SYSTEM_RESTART &&
>    sdkp->device->manage_system_start_stop?
>
> Thanks,
>
> Bart.

