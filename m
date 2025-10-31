Return-Path: <linux-kernel+bounces-880355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0CC25956
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964571A60F62
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F2D34C12B;
	Fri, 31 Oct 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uArwuJIw"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BAF34403D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921123; cv=none; b=s9nch4IU1f7qAV1O4Esg7M+zitNE68DGAW/j3ec1+QinDukyFSwZdKca/ZxxESf8duHHAoqwae3LXBfvBa2fqipSnG185+dJslOuRNXrSLcPPRR+yDxutRi7xDRi8zt0QYjKuweEvbM9pEzSCpMy7DaiJmVmP703sZ83YT9PeJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921123; c=relaxed/simple;
	bh=ztfuXoIA/8/IzjLvWd47nqIEIo1a/dLhajOHezVjkdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln2mLAMH5ba1FgdvE4PUstoRumVUx4f+MXDuGTPPuNfmw1BZbEzEPpo6igRLDL0FYK1SspVANdZT2epXDD5eX5zBlNvlkMEmRSlKYrSC3mKkvF9qB1XmLHcnkF4uzHrrQz4WYMfpHHebOvZ0joTzryDb4iERPdL9oJUI7DFgCeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uArwuJIw; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso306761cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761921120; x=1762525920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G95L3DLvS/DNATNYDSMXETdETrIxVgxQLONU1k6QAU4=;
        b=uArwuJIwTUniNEAA1PprRS9oxhVNtU+Ai4/DpvgpGCUn9Jkopj5BLEVeS/4VvuO/91
         hSXFptaPKgu38herXRTgyb5Pc7eZfyY6jQvANkzPQNpAChchsrOBpKRJw6eQJIslAlfM
         QJcU2zWwF6AiAJlbfekRjUSDjVQrYKniyokufIkvJjRclbR7qs2s23SbmW73TDWiFIAm
         5HHINoJ+1lYHWO4TwgbkeMkZ1rjMNCWn2rw2/9c5P7HncsomvO4xsVhmV5ZWJDblyIHy
         56b2LRileIiXbNJ++zHPh3mLsg/JOioK3ghMMq0AMAfp7rTIxG5tzI0yDKazxbHKIXZC
         SPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921120; x=1762525920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G95L3DLvS/DNATNYDSMXETdETrIxVgxQLONU1k6QAU4=;
        b=spNlzE0UEW+TftN5rZdF730J0Cqau8O61/67m4kKLQDFp732z2XCQkWK2hhVCSCOr2
         S6RXlntTEamZGFOlZqAoceQgarFoC1WcFcQ1qnyECMcylEVEC5BEarnN2Jdkz2FLZpDH
         X/0WKeRZAqWYCoMgoyVR/8KHirgzSTuk/2OOSXFoS9heuUu2mycLTSKSqE10kR/eExiH
         9Bwwjz7tVmsZVYQx6UEcyI33VqnNzxOpFkN9vmYIRMaZGp0lQ2TCg2VPzxWm4wVx1Pdy
         px9UeBFgY67n7lQTQ6jBBekfwuqjDK7iDqikrlyhv1iOqJwFCSG1UJOv3PQyZk5WoWdR
         XImw==
X-Forwarded-Encrypted: i=1; AJvYcCVHuRNeD0CQ13Li5T39lASyBT4ivLd+YLn2PlJG6RJSLRBvQAUghZ1sb/vkKE2/WCpaBkGqGFh+0Y8lIV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGe7jMrEz6izX+YUe24KniBpPeXiv1uyDynlGxYIGytartMaor
	A8yVh8WIDu11AZG0D6Z3Dr39uePRZRB5xPSLoLXDWcMh21o6DlYURDw7mci3Hmr+7ASkipCMOWC
	Y+k2doPzrZYK06R1PiAxsNWc/2CGgiXY5EcEhsSRi
X-Gm-Gg: ASbGncsaYeRsYVW0G1qwI+T9lhKGvoeh5sqY4Wo/yqEqEX16UPrhuHQvxKWDgpllrkL
	TGnS3PxfKGMELVnHhmfBauA+jC/r+TPZ2mXVxgN+T2HfTqMUWQk+Cy+nO0H1RvKhXAVWgiedT3T
	UXuB/FhiRB/8E/4hIKA5Q/fr8qxkCq/C8mWlN4imC15jsEy+7eHBmkpsuUzAocptm/5HLZfBaow
	J9b5ZMimGyJU5S6uyXnH4jBD7a3DVda+tGYx6rq+LBramruf3XeTW7pKYlPqHKJBYEw2gF71OBa
	teXfTFs7dp7QZDsWVTPmu8vWNIk=
X-Google-Smtp-Source: AGHT+IF/Qso4SJD1J9Awit7eARmSYManprQ6V5RDK+znSyKxcoLwTsKzFBHsprkHmdeX77HTkMxjecZ+rWe1vvB8RLY=
X-Received: by 2002:a05:622a:1817:b0:4b4:9590:e091 with SMTP id
 d75a77b69052e-4ed3385bca2mr5839331cf.5.1761921120002; Fri, 31 Oct 2025
 07:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001025442.427697-1-chao.gao@intel.com> <20251001025442.427697-8-chao.gao@intel.com>
 <CAAhR5DEQw9eMVJ_mWRP3G=XqmsR4_46xh030_Vtyx3HzWXn3wA@mail.gmail.com> <6903ef44cbf81_10e9100f4@dwillia2-mobl4.notmuch>
In-Reply-To: <6903ef44cbf81_10e9100f4@dwillia2-mobl4.notmuch>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 31 Oct 2025 09:31:49 -0500
X-Gm-Features: AWmQ_bmbnxKmBqKoD8vD9Ui7lZxDASP_7X1rDLL5Fan3JEh-qcGYvqIWKACARo8
Message-ID: <CAAhR5DGvDoCd_OZURF604LO0JOHoFjWM8Btk8uS_jzJVfk5J2w@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] coco/tdx-host: Expose P-SEAMLDR information via sysfs
To: dan.j.williams@intel.com
Cc: Chao Gao <chao.gao@intel.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com, 
	ira.weiny@intel.com, kai.huang@intel.com, yilun.xu@linux.intel.com, 
	vannapurve@google.com, paulmck@kernel.org, nik.borisov@suse.com, 
	Farrah Chen <farrah.chen@intel.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:05=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Sagi Shahar wrote:
> > On Tue, Sep 30, 2025 at 9:55=E2=80=AFPM Chao Gao <chao.gao@intel.com> w=
rote:
> > >
> > > TDX Module updates require userspace to select the appropriate module
> > > to load. Expose necessary information to facilitate this decision. Tw=
o
> > > values are needed:
> > >
> > > - P-SEAMLDR version: for compatibility checks between TDX Module and
> > >                      P-SEAMLDR
> > > - num_remaining_updates: indicates how many updates can be performed
> > >
> > > Expose them as tdx-host device attributes.
> > >
> > > Note that P-SEAMLDR sysfs nodes are hidden when INTEL_TDX_MODULE_UPDA=
TE
> > > isn't enabled or when P-SEAMLDR isn't loaded by BIOS, both of which
> > > cause seamldr_get_info() to return NULL.
> > >
> > > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > > Tested-by: Farrah Chen <farrah.chen@intel.com>
> > > ---
> > >  .../ABI/testing/sysfs-devices-faux-tdx-host   | 25 ++++++++
> > >  drivers/virt/coco/tdx-host/tdx-host.c         | 63 +++++++++++++++++=
+-
> > >  2 files changed, 87 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/=
Documentation/ABI/testing/sysfs-devices-faux-tdx-host
> >
> > Trying to apply this patch locally fails because
> > sysfs-devices-faux-tdx-host does not exist. There are also conflicts
> > around drivers/virt/coco/tdx-host/tdx-host.c.
> >
> > I'm looking at the base commit specified in the cover letter [1] but
> > even the current head of the tsm/tdx tree [2] doesn't have the
> > sysfs-devices-faux-tdx-host file. Are there any other dependencies for
> > this series?
>
> I hit the same head scratcher, but then realized that Chao did say that
> you also need to apply:
>
> https://lore.kernel.org/linux-coco/20251001022309.277238-1-chao.gao@intel=
.com
>
> ...so:
>
> git checkout -b $branch 9332e088937f
> b4 shazam 20251001022309.277238-1-chao.gao@intel.com
> b4 shazam 20251001025442.427697-1-chao.gao@intel.com
>
> ...works for me.

Thanks, I missed that one. It's working now

