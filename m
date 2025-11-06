Return-Path: <linux-kernel+bounces-889162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575BC3CDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 568484EBED7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A39234EEE5;
	Thu,  6 Nov 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InS5HDex"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37F534E745
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450205; cv=none; b=KxUaTl4L59aa87f4kA/H/xAWqpypQ/xGRp8cSZeGco0xvWGNmpCFuPfwpC26AyjMhdfsxQ9CliSwR+Uu3bM4QkjvkkbUlsxr6GrVmliX8cTs11ncoAbhgYcqZ7DhoSQw4VybcLhLRLU208h9divQCXUBy9AQDloWq7PfJUJVcm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450205; c=relaxed/simple;
	bh=oQD5zik6lmJrm4iJj+XOR0YoeWD/ptGzzMxsrnq0/Fo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kh85EDNU9mFzn7BJIYpQTW+VpKLn0mSfPGH/9CKPRkAHwHGbf1bePXgwCqY7LOABdpfJVxk0k7gU3v+z82LtjhFv2jWT5oLAscqBh/VZWyVqaClb3kulqelR8FeQRD2RDU0QbtEfxkgcPx+0jRY0DhpmHN1eH4pbT8fU+1ZfMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InS5HDex; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so7469905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762450200; x=1763055000; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQD5zik6lmJrm4iJj+XOR0YoeWD/ptGzzMxsrnq0/Fo=;
        b=InS5HDexJiP5kP8JA5FUkBxEX4yRhTi/zM/icUUFPBB9w3TMICHMcz+OEpBK4UNHSS
         KFEbdlYY3wTxM6u4x9ulTUcZlJVHRpgFHT/LZ/Zi2oxTEFZRNpcUjay7xizish0HyGlq
         gquU5HenJ1bnwgyR8byazvArTgkmULPE5hce3pJcVeATteQOQRun210GPqo+n3Ggr26O
         jSuD/1kfLeMwJKGnAGmPb1AUI30aKLah4N/StYmPBAApoDuHSpMIGpoj+Z99bXbdTkKb
         6R0T0swmhdIPuh5yX2bbH8qURmrrge9ggE5qrCcehhPNJKPvL/CheS06wVICfbb6CaGj
         /j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762450200; x=1763055000;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQD5zik6lmJrm4iJj+XOR0YoeWD/ptGzzMxsrnq0/Fo=;
        b=QKWDadCMKVENKhfItuMtCFD4Aq3XyVigWrh+Ngt73qz0WqOa80k5DpQP9WMKLqMFsT
         HGRzS8MnumurEbF5jN944GaiVdWH0XTbQf/8ihZyycE0hhodGNUcqNONk7iDrKN9XUuf
         C38RZ3GwDvC5qp0eByy0o6hpQm/YWj6djLJ94lSBW4uLQh2vLPlH/n/gIpK1VgG30WuV
         VTDdO6adAn5GPb7HwRdRm+NWFQTs5f094UbxVXZx38Cj1DMnRTAchZnxD5m9kkWwOJEa
         TW+C2JCnvvnRRpormKYEBXOTwrk5h/y5vrfjfwpY3NKtf0pFB9KqgLcRgeSGYlsqIsOG
         pxUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyNCc7kj2QeuMWBSYChyCCqADvXLdHtZrTLtpcOD8nfLbJJjXiOtB4b0GW8bLb2cRRjTiuc8aT9G0hylc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBMN6EaRJ8HKHoW2ssg4YZ2ym0m0+5I1GGcwa2i4xSFPvjSTSH
	CoawRPEVcHCGb4DoeIzJqIoSBh+O01j5SAO9dZrmeE8iK4UFbeK3HAjr
X-Gm-Gg: ASbGncunwFBLn7H2rm08m0T9xs2ihmhPxzIFfiMVZG3fofWfas2DCGObshxcCtL7xFr
	p5eH+eQ5PXtYcSyz0hiBK5nOAq1skzptE/I8CqbO1inVqM0HWWrU7q0mjuma825r4r5GtZg+xcv
	5FalR/k8c2v7ShOyuShpEi30oJhL5hAUm4Ks0EQhARSflXTN2jgbz6cx+KQEz+teVxIE6E1cXNN
	6G1/G7PE+8PpijmVgphZ7aKU+2jrDWXMQlaZnmDbEUcGafBJQsmvlblYL1sGPmTN5g2nPhZHl/c
	cImDIYZJdw/X0xxgOgLQH3aQGZDbVd5HVJOYUpBj21AU1yiFf2uDvS3dpa6RIJaF3AnEGjxNeGW
	+HKZNlU/I4kQL2G1in3nfkoF+LtwYlDEqu4scUVwcEjzyCXzmXC49wZb2c1nzjPOJ1AoeyUH69I
	JIgHoMDsFswRTCAA==
X-Google-Smtp-Source: AGHT+IEps87NwAd+lPUa70y/vz/9kCpABwD2KzGeMJJV+bnYKu4Iq5yog0yPFgKWsXsgB44nx1VtNQ==
X-Received: by 2002:a05:600c:3b0f:b0:475:f16b:bcbf with SMTP id 5b1f17b1804b1-4776bcae129mr1007825e9.14.1762450199996;
        Thu, 06 Nov 2025 09:29:59 -0800 (PST)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca10sm294822f8f.26.2025.11.06.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:29:59 -0800 (PST)
Message-ID: <8de3c5c04fede7ef0b3a62cdbbec133b579430be.camel@gmail.com>
Subject: Re: [PATCH v6 0/3] Add OP-TEE based RPMB driver for UFS devices
From: Bean Huo <huobean@gmail.com>
To: avri.altman@wdc.com, avri.altman@sandisk.com, bvanassche@acm.org, 
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	can.guo@oss.qualcomm.com, ulf.hansson@linaro.org, beanhuo@micron.com, 
	jens.wiklander@linaro.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 06 Nov 2025 18:29:57 +0100
In-Reply-To: <20251026212506.4136610-1-beanhuo@iokpp.de>
References: <20251026212506.4136610-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Martin,=20
Do you need me to rebase this patch series? I noticed you marked it as defe=
rred


Kind regards,=20
Bean



On Sun, 2025-10-26 at 22:25 +0100, Bean Huo wrote:
>=20
> This patch series introduces OP-TEE based RPMB (Replay Protected Memory B=
lock)
> support for UFS devices, extending the kernel-level secure storage
> capabilities
> that are currently available for eMMC devices.
>=20
> Previously, OP-TEE required a userspace supplicant to access RPMB partiti=
ons,
> which created complex dependencies and reliability issues, especially dur=
ing
> early boot scenarios. Recent work by Linaro has moved core supplicant
> functionality directly into the Linux kernel for eMMC devices, eliminatin=
g
> userspace dependencies and enabling immediate secure storage access. This
> series
> extends the same approach to UFS devices, which are used in enterprise an=
d
> mobile
> applications that require secure storage capabilities.
>=20
> Benefits:
> - Eliminates dependency on userspace supplicant for UFS RPMB access
> - Enables early boot secure storage access (e.g., fTPM, secure UEFI varia=
bles)
> - Provides kernel-level RPMB access as soon as UFS driver is initialized
> - Removes complex initramfs dependencies and boot ordering requirements
> - Ensures reliable and deterministic secure storage operations
> - Supports both built-in and modular fTPM configurations.
>=20
>=20
> v5 -- v6:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Added a comment in ufshcd_create_device=
_id() to warn against
> modifying the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device ID format without under=
standing its impact.
>=20
> v4 -- v5:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1. Added helper function ufshcd_create_dev=
ice_id() to generate unique
> device
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 identifier by combining =
manufacturer ID, specification version, model
> name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial number (as hex), =
device version, and manufacture date.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2. Added device_id field to struct ufs_dev=
_info for storing allocated
> unique device
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 identifier string.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3. Modified UFS RPMB driver to use device_=
id instead of just
> serial_number for creating
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unique RPMB device ident=
ifiers
> v3 -- v4:
> =C2=A0=C2=A0=C2=A0 1. Replaced patch "scsi: ufs: core: Remove duplicate m=
acro definitions"
> with
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "scsi: ufs: core: Convert string des=
criptor format macros to enum"
> based on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feedback from Bart Van Assche
> =C2=A0=C2=A0=C2=A0 2. Converted SD_ASCII_STD and SD_RAW from boolean macr=
os to enum type for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 improved code readability
> =C2=A0=C2=A0=C2=A0 3. Moved ufshcd_read_string_desc() declaration from in=
clude/ufs/ufshcd.h
> to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers/ufs/core/ufshcd-priv.h since=
 it's not exported
>=20
> v2 -- v3:
> =C2=A0=C2=A0=C2=A0 1. Removed patch "rpmb: move rpmb_frame struct and con=
stants to common
> header". since it
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has been queued in mmc tree, and add=
ed a new patch:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "scsi: ufs: core: Remove duplicate m=
acro definitions"
> =C2=A0=C2=A0=C2=A0 2. Incorporated suggestions from Jens
> =C2=A0=C2=A0=C2=A0 3. Added check if Advanced RPMB is enabled, if enabled=
 we will not
> register UFS OP-TEE RPMB.
>=20
> v1 -- v2:
> =C2=A0=C2=A0=C2=A0 1. Added fix tag for patch [2/3]
> =C2=A0=C2=A0=C2=A0 2. Incorporated feedback and suggestions from Bart
>=20
> RFC v1 -- v1:
> =C2=A0=C2=A0=C2=A0 1. Added support for all UFS RPMB regions based on
> https://github.com/OP-TEE/optee_os/issues/7532
> =C2=A0=C2=A0=C2=A0 2. Incorporated feedback and suggestions from Bart
>=20
>=20
> Bean Huo (3):
> =C2=A0 scsi: ufs: core: Convert string descriptor format macros to enum
> =C2=A0 scsi: ufs: core: fix incorrect buffer duplication in
> =C2=A0=C2=A0=C2=A0 ufshcd_read_string_desc()
> =C2=A0 scsi: ufs: core: Add OP-TEE based RPMB driver for UFS devices
>=20
> =C2=A0drivers/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/ufs/core/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0drivers/ufs/core/ufs-rpmb.c=C2=A0=C2=A0=C2=A0 | 254 +++++++++++++++=
++++++++++++++++++
> =C2=A0drivers/ufs/core/ufshcd-priv.h |=C2=A0 27 +++-
> =C2=A0drivers/ufs/core/ufshcd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 96 =
+++++++++++--
> =C2=A0include/ufs/ufs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +
> =C2=A0include/ufs/ufshcd.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 12 +-
> =C2=A07 files changed, 376 insertions(+), 21 deletions(-)
> =C2=A0create mode 100644 drivers/ufs/core/ufs-rpmb.c
>=20


