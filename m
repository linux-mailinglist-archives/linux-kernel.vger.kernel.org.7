Return-Path: <linux-kernel+bounces-769832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53EBB27439
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF94C1890E27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37448131E49;
	Fri, 15 Aug 2025 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibCFfDo4"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017ABA3F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218961; cv=none; b=D6+BIfegTbzY5wK83Zm1juPNjCCZBq4zK2N1oHyCTkPn5SPU+mw6U5QKRhyXyaJGGuLSiwSr8qUF/CXfhmgtO0aMiiht3N1hc/7SHQ/yumMhaeOFZ/zVQ1wm/DFNvMtNsHhr6i4iEMMPng1G8ZE+ULMSbAwl4Y5TlnK+4YwvQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218961; c=relaxed/simple;
	bh=vPDeq+2DCIie7wbpdXgHvtiU9ESJbF1yvqLVOyQUXC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB4iif5QN9W3KJbmu3XV1erdJImNST5kESH0pAbUizktPwDH2kVLfqiKwyrFSW2QQOJz1m3TTjXRwzr0qTadHCc3ZJqaDzKr6+IujCFc4YCJ0ABKVhJ6cmtDJT0y8dLEMUA0ziwqx9vSODIE5q1h+0jhj7NIyuoWedTSUHqHTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibCFfDo4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb78c66dcso235223866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755218958; x=1755823758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxJI9V2/5brGzu15gMcFVUD4p8pvOCSJS6i60fiFax4=;
        b=ibCFfDo4niZKbK8VGF7buhwHR2+S604wvt+VrWQvy/6sIFW+OWwGmuNRHS1noKLT2+
         oILIPRLCFj1RwQe/zMa3gMcY2speuSt2aKhMBZJGx72tcnE+peP1eit8yizbKh7l1SmV
         5tzlUJ4NVOwfk8m5cHSOowWjhBK0Z6OpDNxWoooublhSwWUoaAlhDQ2yKKL897umD2xk
         hpvOsCDbWDkXwY1VoOQ/WpiZGi1j7+z/+BjJKPo/J1tXuD7bjQ5JmDhQasuWLmOh816J
         ETLiHSPJoXpaWENzsnDuRa0tOdssd5RRbG706SN887w8tWtmYkYyZ1GXUDX7EQsoFmDV
         Qczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755218958; x=1755823758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxJI9V2/5brGzu15gMcFVUD4p8pvOCSJS6i60fiFax4=;
        b=WLvLkMActSUxj2F66tpbDASulS1OeFKyK3KDGoSqCOYNasSxEA4VONdhCvfaxdzy1e
         QzJ4lcAVwHS62333E5yogMEXXI7coWfujcyPjvETRsRpcA3Razf/AWKLI+XFaBjrHWrF
         +E7Wn3WxzbxPScH6b9Tr4Mq0ukpHgiH0MDca/fvoYTMZx3PL/8Nq9/KSpLibSnV9R4Sk
         w4Zk3kn8wzkbqiYnFndQNoHG4XmNeQnATKsAGIX3nUxfKudEjrZUHV3OaVyfYFHZrjkd
         A8tKKTIJKCkmB5z4APmbSfG1iH2lGpVStHDbBM5hNjCU/cC+Dm+TGLaDLSbMeDC4hO+X
         dT6g==
X-Forwarded-Encrypted: i=1; AJvYcCXpg8HiK5HCc2wP7sZogBCgrTMmT/hj+pW76AgFvXY4htypAplqBUcFPAbEwW0u2HwKY+H2xPsixAOf02o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ht4rE2JlMCAF0jQkftJ5wcvkVlBdLaRQu/tVByhLKdNPbyae
	Hje8G777PV0VmsmW7g1G+4PguAnN6RFToPLJxf9Sm62yYT/PikK/tDsrtG7xHS9TEjL4LRKSV4V
	MzFyZbdSSTgFKxzGKQBXbbGXwqWXLUeIAM/78GhbC
X-Gm-Gg: ASbGnctVMRhsp0sNhXHyCMLFc1jDbl8kpu3168bmDYJV8pUsRq9FFVHXETNhUm2Rn5Q
	k04/KT9Y1kRkze/Vj3DAMwez5izLq6Ln3a36wZMIgKX8fBtZPdCAHDHQUrgWaA133a5xFvFGUNQ
	ZKeSVlQzSXOlJcBLAjUZj61YGp9gP3ngc0l8S3ARxCEhmVCNfgB0CL63GVkCIoTM8XifvlBIePm
	K0k0s00DdftZViiG1L1P9bRpNvSjN5QmzB4sR+yigjb
X-Google-Smtp-Source: AGHT+IFt4k6OFVoKePCnvLLuvP5qwSUYLc1MlmMCMEp0GFJhfY9RjqXDNaX0k0KuFHceKDLyi7aTSGbDNYEPxRGz1Lg=
X-Received: by 2002:a17:906:fe44:b0:ae2:9291:9226 with SMTP id
 a640c23a62f3a-afcdc2bda87mr13464766b.59.1755218958152; Thu, 14 Aug 2025
 17:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812232126.1814253-1-wusamuel@google.com> <2025081359-survey-sprinkled-e6dc@gregkh>
In-Reply-To: <2025081359-survey-sprinkled-e6dc@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 14 Aug 2025 17:49:07 -0700
X-Gm-Features: Ac12FXw4bTiBvMbUfA5qcuR0BBiSCS1moprtqKFT3glNKO2GbV4EfI6aS7GTsqA
Message-ID: <CAG2Kctr8rzjjPtc3d-fCEtqxxkQacNKgBqstHZWgE9-xUmNLeA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: Support aborting suspend during filesystem sync
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 12, 2025 at 04:21:23PM -0700, Samuel Wu wrote:
> > +static bool suspend_fs_sync_queued;
> > +DEFINE_SPINLOCK(suspend_fs_sync_lock);
> > +DECLARE_COMPLETION(suspend_fs_sync_complete);
> > +void suspend_abort_fs_sync(void)
> > +{
> > +     spin_lock(&suspend_fs_sync_lock);
> > +     complete(&suspend_fs_sync_complete);
> > +     spin_unlock(&suspend_fs_sync_lock);
> > +}
>
> Why no documentation for this public function that you added, but yet
> you added documentation for a static function that no one can call?
>
> thanks,
>
> greg k-h

Thanks for catching this; updated in V2 of patch.

-- Samuel Wu

