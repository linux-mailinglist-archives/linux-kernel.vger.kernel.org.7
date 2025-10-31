Return-Path: <linux-kernel+bounces-880967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFC7C2710E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6324F189D911
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBBA31B13D;
	Fri, 31 Oct 2025 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBc/56BT"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07226241664
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946904; cv=none; b=G/T9iE1PYAfKhrMAmXq8rrzuIzX1vzG6rJRZ73GsK8RGJQLKxHwlUjNu6GUif+IF6PMge+negn1wqJAdte81/d9be1+eNE9NWv3W1cmvAsGeP2OPbZ3WKsVG62ttTP2mYO0C/5VpTuT/PcvPE4y2hckOqjPgVVWqnji0iOVzGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946904; c=relaxed/simple;
	bh=eLQIYWaVPW49aK17HBWd1NWzjca/Qm0rfLEwUldyuNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL+AhZClhh/8IqaQWcHUj3KwjjmymEmSubHJ7TEEmeV9ulMrtNDWvnhjhzB+YOc6maaLdJezwvkODJlZ1NKw9MuV5toJ/i8UIGbTWR8l9Lbm+k5n3MDrzSJgn0GfaPY87gwpalPcteQExnoziU2IT/Kyx1VxOmnWlQjIDfznFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBc/56BT; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93516cbe2bbso373929241.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761946902; x=1762551702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgDmmhPmt8GWeeRC0I/+oZ9vobNYjk5v0/zKbM027nU=;
        b=KBc/56BTegzCNHDAOB+1xs8j34IyNk/qcQe5fPQsUkoo+GOM3lpQNVq4mW9UP7hycf
         q2UR3OT8M814DZaL3HzFVkOWaj9grlX5HvEWgpP6SSAibqoDH8OATtfSjNQpuuJ7CRAE
         9wrWJMYKx3oQLrd3NU4iQfP7vK7sDFxzUOAzWERz/G5C19igImnOCvHf/r+NRvbyEZER
         +FkHaMyrgHL5MQLPJr0UspXMuWJqf0ZtXES7m6LMH39erHXBpE0TH/IEY6mvEMtHzTuE
         BZWoc8dIeKHFZABpqALwHV1mKKREO0RANklUkX6d4Yuqn9cQIbYU+dFMYe/SBOJDB5gs
         Soyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761946902; x=1762551702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgDmmhPmt8GWeeRC0I/+oZ9vobNYjk5v0/zKbM027nU=;
        b=j/B5TBmvutlFcf/hpXxJCBfxyPGZ23tAo51p350klBIW4ZSvpn5KkUufzUyjS80Gou
         bekKZiAexWVI6VtyjulSYSVXq/gFSqt6XISKYjFLoaiwYUxGk+G7Y6vc+Me5lNVR/82b
         IN71i2ofyJy17CmJ1SIEimCr1zRQxDAxhR6Otn/E3KQs/6kFbYI0oaNxN9BIBFTs7PYp
         7CTUfUU41bbX9OmOcngIRRsamastHTJZsnLzVt/rlHlRCTOQNe4ndoXfjNTkbDnwlZLc
         ZNR6D7YE383PTsC9nKpcQmYAFVYMXvRdP7fX8e3KBD/qaBlkrSMNFp0T+h3APNAHE2hj
         GcTA==
X-Forwarded-Encrypted: i=1; AJvYcCVki/Zm2hW8uOvCfb069bX6BE9FQft+ycfb1mjBoJnx85sxfG3LIKjss/EJORJFbHLc7eHPnAlMsPzOC/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1amOysoZ1auzA3OfmHJQBQljNVsW57/jNoJBAmPbzhyqDZDKL
	6aisitbTTVeP8gqM0EOUseN8sXVjFQmTRLLUUi+SMzTSC7K+Cs3m9zIf2QU5Pe5j6Oqs1DiRqj+
	kVR5RA0rXR8bD3op8hY7q3ptYt0fu+ad3SY+XYO0M
X-Gm-Gg: ASbGncu0KhhqBXK4GUlZrcvHvfSSn9Qem8RTMALBuTlId1ex/kPnXAEPIDcCqgGQwrc
	SYwks4cRh6L4yv8C6ABm4h6KODNYBLzyX8eELTAuTIz/X7c4fvbdXgRVO74w5IUTpdj5x0a+IKJ
	6SckFvSmXGkI+Bz+Y6A9s3QsU8IfgbfRBS3G5ZeY86QTZ9futErQaxa6Xo1G/Aa3S4BFieXkm+Y
	/BkdD83Z2DawxCbDm0FTNeT8pJCivjDaJ7s7Jpbou7zFdQBMV5gLg4HqILA9GKimK/52cw=
X-Google-Smtp-Source: AGHT+IFnL59KMQOmHhDnr7StsLJBnGLpWS8+HKPSaf+PGPTng/MnXyN3J3hLa7MWF1XMOBaYdatCX/yrEEtPHOOkEjI=
X-Received: by 2002:a05:6102:38cc:b0:5db:3935:1636 with SMTP id
 ada2fe7eead31-5dbb12ee641mr1575830137.26.1761946901748; Fri, 31 Oct 2025
 14:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com> <aQPwSltoH7rRsnV9@google.com> <CA+CK2bD-E0HKsuE0SPpZqEoJyEK4=KJCBw-h1WFP7O1KEoKuNQ@mail.gmail.com>
In-Reply-To: <CA+CK2bD-E0HKsuE0SPpZqEoJyEK4=KJCBw-h1WFP7O1KEoKuNQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 14:41:13 -0700
X-Gm-Features: AWmQ_bktJi7f0hZJNBg0hayd2_71DzRkKbUhfBoiRXCBpPspKaQtLxcKUO1Amvo
Message-ID: <CALzav=dd3eAgqiWM-MKhu77xq0iWRMrESkDaT9KgzNgSvcjeVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, Vipin Sharma <vipinsh@google.com>, 
	bhelgaas@google.com, alex.williamson@redhat.com, jgg@ziepe.ca, 
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org, 
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, 
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 5:19=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> On Thu, Oct 30, 2025 at 7:10=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> > On 2025-10-27 01:44 PM, Jacob Pan wrote:
> > > On Fri, 17 Oct 2025 17:06:58 -0700 Vipin Sharma <vipinsh@google.com> =
wrote:
> > > > +   guard(mutex)(&device->dev_set->lock);
> > > > +   return vfio_device_cdev_opened(device);
> > >
> > > IIUC, vfio_device_cdev_opened(device) will only return true after
> > > vfio_df_ioctl_bind_iommufd(). Where it does:
> > >       device->cdev_opened =3D true;
> > >
> > > Does this imply that devices not bound to an iommufd cannot be
> > > preserved?
> >
> > Event if being bound to an iommufd is required, it seems wrong to check
> > it in can_preserve(), as the device can just be unbound from the iommuf=
d
> > before preserve().
> >
> > I think can_preserve() just needs to check if this is a VFIO cdev file,
> > i.e. vfio_device_from_file() returns non-NULL.
>
> +1, can_preserve() must be fast, as it might be called on every single
> FD that is being preserved, to check if type is correct.
> So, simply check if "struct file" is cdev via ops check perhaps via
> and thats it. It should be a very simple operation

Small correction, vfio_device_from_file() checks if file->fops are
&vfio_device_fops. But device files acquired via group FDs use the
same ops. So I think we actually need to check "device &&
!device->group" here to identify VFIO cdev files, and then check
device->ops =3D=3D &vfio_pci_ops to make sure this is a vfio-pci device.

