Return-Path: <linux-kernel+bounces-897858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EECFDC53CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26F98344919
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F44348894;
	Wed, 12 Nov 2025 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKEtv3y1"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8023BCEE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969927; cv=none; b=a6jsIZ9QB2lL5YtmhgYSNJ2tkpCVFMwT/qNvzdws6tP0Bxy/ypw/Ua3upzBY6dcVodrmXoMQpkiieql9chA0y1GBoyjobLYLeTaO2U7uHlkD/8Cp/bcDDxadZjpmYUEiivQ8/Q4Hfkv90wAkyJanuZsw7MB336hJRhnCMdRFSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969927; c=relaxed/simple;
	bh=1nPIUcHHQkGuDuEReWgowmjbEJHx+aY1oV5caXaVwD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N74LHzEb0kfI6yfXxv3YzH1096XhZwwKXFURpnofAaOD5MFLE7RSLEAo7RLS/1WubmfiuPeY6oeKSTAM/lNjZaqKo7dH3FRdwjiK3yl5kNjJK6wqiIH7bKArlTelPz6HR7ynHQB7VdiceSryUZYHI+fjGi455cBQhLNYuW+1E6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKEtv3y1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943d1d0656so1494736e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762969924; x=1763574724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWA7RPE90uWMLfiUEvRQf9rnUzfEKRuTRKW0waWBvtU=;
        b=XKEtv3y1lmMBy21nO7bUwZlqqwhAgY3EHrrg2Awcz68fMxOKN5XczXaFGI98PzTCr6
         gn7Cep0VSXXysm0l9qOa2n9Z+/s6pTpENot4pfWqWc9Rj9fjzeGC4gIRDNmKtz3pftmv
         aWoklNBjcd92QRC4skOp3ocOJjsUDaJEJSsrROeHJTmJaPnO892x3E4sl4kvYZPsoIG8
         3R9scMz8B7NmaM37OwZBoF1E5DyOqT0nDRwP2o5Ca7yMycGJAQdhjq4vkqJnt7o3ij87
         voDzFXSOoj1r4i6nJV51xWKDMrX1hJcUbQMdbRtPCyBdRHjJVN6QlU/2dxeZn5sKGGQ3
         uihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969924; x=1763574724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BWA7RPE90uWMLfiUEvRQf9rnUzfEKRuTRKW0waWBvtU=;
        b=mLvEqlR0ZDnC7IfZr62A4d2R6dnlPHlWgxEM361CiKONWwm1OYFpLItgCbDrlFQxKl
         rUqnElFKTeTM56F2pKsxa1Wk8HOMLX1r9JFYdjxdoQERPrF+ZtlmkPk7dm26QUvWF+TF
         60dgD0epkKFQCaizU+i65KtHo8ai56mqzxSYGkzlEIzLNA05opyWK9AAOsl0UlEJM3MQ
         wCv0cK9Im13EhQlSjKpdgcWYJirJ0WTtbNBFDsYD4So9YUMZOE2VodoJsWXFfN5Wm80B
         VmM+Ab3SOezs4u8dq7j+WxASGI5r74p/p9axdDiI9E/fic3eAh5WYpCipBOBaPl6a5Pk
         aPMw==
X-Forwarded-Encrypted: i=1; AJvYcCXxRXRErKHDeG/WfpFeNO0PZXPlKgbpZ42YdzbIrnq1DY4ZGdzQHaoEUgfj7mhn6LoE5dfvF9omd04cCNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbnXkGOwaOiyAvdmqa2uwl81LGvGv9Gc7om2ECzCBgiX8Pai4
	WBPIgXWDTnqb0/r0bnAyXcAEiDn1m5WYDNuLSmCgy3HGTqnKfwYaC0JxmtoczoOe4qqVW5ppenJ
	nljAom3tttOcpW468x+J/dwW54SghV2x+SSD+FYEm
X-Gm-Gg: ASbGncvXQ/2tgdPEOItsED4JDWDhDHBpgewJrRmXzgvnIycsStCKF273Ei83BGH3ODI
	hMJJqsjL6N/0ZXSRuXTH7o37YTUX2oYPbQhignQ0hgxUBeFNKXdxAbx70N70UGd630p6MaDxZL0
	9+02NS+l2OGcrixPQt69featRr/S0ZpwbLppgKPqJDGHRIJ8lmORjNniO7fHF2o1JjGxA4YcABL
	OVr2e+ZiqfItZLIVi7fe3O3kxxc1Vdxq8CVwDZb1dvKXJysYiUOLa+8XXZkccr+h6/6m2c=
X-Google-Smtp-Source: AGHT+IGZlui+q5RWh2nUGIJx37r549PQ7MH8JxhyuFkGiNy9V2zSJZ657BZLVXRVqOqTvVTllHIpqyOu4vKlX8Ljo0M=
X-Received: by 2002:a05:6512:1318:b0:591:ec0f:fa92 with SMTP id
 2adb3069b0e04-59576df34f9mr1398580e87.3.1762969923158; Wed, 12 Nov 2025
 09:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
 <CALzav=cmkiFUjENpYk3TT7czAeoh8jzp4WX_+diERu7JhyGCpA@mail.gmail.com> <aRTGbXB6gtkKVnLo@devgpu015.cco6.facebook.com>
In-Reply-To: <aRTGbXB6gtkKVnLo@devgpu015.cco6.facebook.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 12 Nov 2025 09:51:35 -0800
X-Gm-Features: AWmQ_bnMhC8vCEPOclLuVLWYsWBnpTFPjnWiWBSvozOncRXWquyM5KNqmbyfacg
Message-ID: <CALzav=fwE2kPqJUiB2J20pK5bH_-1XvONQXz1DpsMSOCKa=X+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 9:40=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote:
>
> Hey David, is vfio_pci_driver_test known to be in good shape? Both on the=
 base
> commit and after my series, I am seeing below, which results in a KSFT_SK=
IP.
> Invoking other tests in a similar way actually runs things with expected
> results (my devices are already bound to vfio-pci before running anything=
).
>
> base commit: 0ed3a30fd996cb0cac872432cf25185fda7e5316
>
> $ vfio_pci_driver_test -f 0000:05:00.0
> No driver found for device 0000:05:00.0
>
> Same thing using the run.sh wrapper
>
> $ sudo ./run.sh -d 0000:05:00.0 ./vfio_pci_driver_test
> + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
> + echo "vfio-pci" > /sys/bus/pci/devices/0000:05:00.0/driver_override
> + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/bind
>
> No driver found for device 0000:05:00.0
> + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
> + echo "" > /sys/bus/pci/devices/0000:05:00.0/driver_override
> + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/bind
>
> device =3D vfio_pci_device_init(device_bdf, default_iommu_mode);
> if (!device->driver.ops) {
>         fprintf(stderr, "No driver found for device %s\n", device_bdf);
>         return KSFT_SKIP;
> }
>
> Is this meant to be a placeholder for some future testing, or am I holdin=
g
> things wrong?

What kind of device are you using?

This test uses the selftests driver framework, so it requires a driver
in tools/testing/selftests/vfio/lib/drivers to function. The driver
framework allows tests to trigger real DMA and MSIs from the device in
a controlled, generic, way.

We currently only have drivers for Intel DSA and Intel CBDMA
devices.So if you're not using one of those devices,
vfio_pci_driver_test exiting with KSFT_SKIP is entirely expected.

I would love to add support for more devices. Jason Gunthrope
suggested supporting a driver for mlx5 class hardware, since it's
broadly available. I've also had some discussions about adding a
simple emulated PCIe device to QEMU for running VFIO selftests within
VMs.

