Return-Path: <linux-kernel+bounces-898333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF5C54EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5BDB34A9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BD1552FD;
	Thu, 13 Nov 2025 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cVLW2eG/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DF72617
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994243; cv=none; b=YZ1xgNkLg8M+jSX81ux1LLIAO53Whw8xwdmUi/HKzqI/o9wQQAGZI1lWw9F73auIpTmIV0US15LuVszMRi+o/Oid0OzQobkl66KX2A0cfw+ZDrIv7qBn5EyOxDVD/hlmncXrpkRsecEJOJA09Ot/V/jAeM9Uyin/KHWgvOgp6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994243; c=relaxed/simple;
	bh=gQAFEkuis6MxG6DQ2tXr7tvJKT50Xpw9bu5kwP7LPfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ddv6MA8TT8aXtNcZVWmVypsUelqVyGwSBhSdFXl/nNkP9NP/PDw5d7vLTGTg7rstgKNSXEKZ4yAbbwMN+r9vb67OykWSe3C2oJUG5AyDchEQLhBH6GCNW5GwQxRh58o/9QpEWFrZYSHmHx3BzBj2ai9snqQx0eudUT3qk5CulPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cVLW2eG/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957f617ff0so233024e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762994240; x=1763599040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQAFEkuis6MxG6DQ2tXr7tvJKT50Xpw9bu5kwP7LPfM=;
        b=cVLW2eG/gPr1sJMBKzZEY21OMPLNeE6ftCtoZGHFrgcHGQMGOmRzQwNKGGJstI1jGa
         Gg6Hv5kPDIeXEeO8S4KLCDmgwMymhkrsr+tePT1TYm12oOLrpQUaMdy41Xv7IODsHaBw
         jjAhtP4CWpRn7sqY7/yBtNDygBBUn/od2EdUKJ54dbbYnV6oJSWwo/r2ZxUTe4umFmp1
         HuRpJvZNBLZKXi5egl/3aUzoLFntjduxNVHuLz5MAgQ7T4Zmiwz8Qe1syrNpqiYkWyJn
         t0y2vp2sgvULVGYQ/k5JNQWy6YWdm1qWIQOeI+2bdT+QL7pGtDdMfADQPU/asLIz0jjX
         72NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994240; x=1763599040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gQAFEkuis6MxG6DQ2tXr7tvJKT50Xpw9bu5kwP7LPfM=;
        b=wKETMvwpHpc4rnnG8M1t8coK1rmR9N8m7qB/2Zu8YSGz8GtxH2YsgYMxFX3ZbKIB14
         lDM+DiuWnQ7BO3nVfgVr25l1DLtvSKK3xDDtgW+TvavvA4l2GEDA14WUTBrILGEuq5gW
         BFQmsIBXd4Guv6kTyzQyBRaFp/l9FnQS6gWF7PT9geJ5hT2RczZv9bwVkTH5fOHzyXM0
         63/e/DgcSNQj7js75KvIWTOf4ihl9SoyUcYOHfqaA3DrBn5E+gpAZSJu7OfV3Ikk80d0
         QWpjz5z2qEY+BiCTl12K07hnVglOpxHTAVWL1VIl1zlhwFF99SfgqZkczr+f5NJyuaqT
         xMHA==
X-Forwarded-Encrypted: i=1; AJvYcCX+eZPg4RPBdEer6is4uuCjNUyXM+Yec69Z4fLsnYHwD/x12p9cAQLcONA0GyY9MNIHkLnzvLR4p4r/Z/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMgcckA/n9ca6Hwv6k5pPn2+dJWGg6JV5VLcN4EsoGo+D7p/VS
	sd2mt1mV5dellneimgdWPQu2YJe9e/yoHPachi58CaeQumiPE4ertXy0uORW3SSAPplNbgKZOOW
	+0AsvynJI+AbCRvkaIxVrqmbE7hXOAg/Z+Rzkr+qN
X-Gm-Gg: ASbGncsrImPzLeaC5hZ0sQLWL4Sn8axoEYQI6/BcwBSD+2YpFWKg864vydJMQpoxmya
	30YoleozWyp0FqrQ9yC3nxfFgf5HSreVLdtg5OlgDcRfKkeDTvSD+OkccKZkHUvoM8vUSB+3H4U
	K5MgQXwK8EtkXF8Wz4+zxItEcYZNgiEPtzp6VNNp9EBB/WYpKfaxdmbqUNofgGFp7fVWUbhE+sw
	Dqldbej5f8m0rWIJ+rKFBdcaHYbmmO1klVDEaedB/6EUPM+Yg3jfXObb4H+dXvXbeMoLCA=
X-Google-Smtp-Source: AGHT+IES/CJsPbrAgyWQnLon15KjjafWzvib+JwHwpBetgA1Zmgy6sN5eKJD/4qlHX/bLU4ksRV0aZSNvBB5EL/4rWs=
X-Received: by 2002:a05:6512:3d17:b0:595:7daf:9425 with SMTP id
 2adb3069b0e04-5957daf9557mr931008e87.28.1762994239481; Wed, 12 Nov 2025
 16:37:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com> <aRUFGHPe+EXao10B@devgpu015.cco6.facebook.com>
In-Reply-To: <aRUFGHPe+EXao10B@devgpu015.cco6.facebook.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 12 Nov 2025 16:36:51 -0800
X-Gm-Features: AWmQ_bk8b8m7l1BLL99RYzxjgrX9eX0t8GUscVQicIffm6eZO-IaDbPjTlCoDjg
Message-ID: <CALzav=fYCutTptee2+9ZDYChxDGFUaOytSwmf4qZhFTRSGRGNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:07=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote:
>
> On Wed, Nov 12, 2025 at 07:22:14PM +0000, David Matlack wrote:
> > This series adds support for tests that use multiple devices, and adds
> > one new test, vfio_pci_device_init_perf_test, which measures parallel
> > device initialization time to demonstrate the improvement from commit
> > e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").
>
> The new test runs and passes for me.
>
> Tested-by: Alex Mastro <amastro@fb.com>

Thanks for testing!

