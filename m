Return-Path: <linux-kernel+bounces-876245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F25C1B0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7CF15A36DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7352BE04C;
	Wed, 29 Oct 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNx03Gt1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2729D281
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745198; cv=none; b=BE6pexLjxnJz5ZoWvMJe+/9KpV71fFPSEB6Wv1qS3JfsU6cHwm4WtfE2nzRRZod3a7glraSWyGvqyZniXsQs0Pe2SDZCCb9hpJy5G+u+t7HLZbUgjJYlQnsmq2M+89wvazyiW+xhcO92HJQOeZuKPUwV7ukJ9F4weKVFDtSCIAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745198; c=relaxed/simple;
	bh=1FkKzTgPbLTlv6s4BQt1xaTgymEsbkipzI4UtqqlsTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueaSn2gAUIu1a8SpHw6Z65UNZmlvUA2ETNk6QLy3qmoAV8RdzZWdwZmuJZ1cIHUSsvBSqtl8AtQFCOQi4MqJlFpber8suyCgKa3/H8/ootmzgzFJLlXPZ+2Cb1P7vvD8kudnVaMnv1fRnShpmMglLysNUmWYdgxICM4SxC77Sxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNx03Gt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761745194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FkKzTgPbLTlv6s4BQt1xaTgymEsbkipzI4UtqqlsTM=;
	b=DNx03Gt1gjDapZU4uHIAHrQYW6E4AM/tJ+HXJAyp4dpK+G9a3lyxCbqUqS/qKAd7uVO2PZ
	RFPipVPev1gZvNCIuHelWWk33CVXWyu0MGDzqdSNH8vydJLxWDwJLEqAAJbKnjBZqXyS9L
	8oGgFBX0hRz+YbIdNURsmnv22ItFtzg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-HyiXx_y8MMut2XW3zZjOCw-1; Wed, 29 Oct 2025 09:39:53 -0400
X-MC-Unique: HyiXx_y8MMut2XW3zZjOCw-1
X-Mimecast-MFC-AGG-ID: HyiXx_y8MMut2XW3zZjOCw_1761745192
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-294baa12981so11993165ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761745192; x=1762349992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FkKzTgPbLTlv6s4BQt1xaTgymEsbkipzI4UtqqlsTM=;
        b=ddqW9ONncIYW3g3fn8/Fc54b6ePkQNy9FEWNNoWwuJprIbseIXoTjyHT7ha7TMGodg
         Y0UrouTA2KqjXSnkLP2gVVWIWeegcgP1VDm+GT3DLFJsHmly1yULarmrVhOGNb16eXcl
         AUswUzgnk8TPeeIoitATX7qoAE3nGiO7mFlcABfjtFIso4S1dVNlen1uA+JATy9x7p0V
         H594ntkiFkOiCv+yeZp6x8bRBxNZ1UtyUfMSyFLnJ9OMvAe75LIM+cJv+DWjWPf6Bac9
         tS0f3eJ6/s8MZ13nN3FJ8YB4Q2aElYOJ4GZe4M1TIuugl1ZaUCbJ4AYFQuujCHyVclr4
         7riA==
X-Forwarded-Encrypted: i=1; AJvYcCWYvCYf+B8VpX3kShIvWp/Y3MzbAKXq60h32U/UjHSRmQ5KxFD5mdSeaU0NPiGsOP5qBYZcOqndfMdUkRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM5OmZa3FQTuq7AHX1H+q5XGyhAnUIi0tOaslfRSkD1gwp1LeY
	u2BJISSI2JtByl4m2PcEmvo1awSEJUypQOgqKpsnOLJ5WW8XAnAATEFD9IylukxWnZ1gkLzRZL4
	gBEnxPy6ozXlTrYJvS5hLbgHLKizjwBvNBIzCtiDpSZxVMb+mblCf6QYPGjFK5Jen7oNW8X43YC
	yMZEFZgJYdOsCk9xMqYNdFYsCu26jv9L4JuMRbfiHQ
X-Gm-Gg: ASbGncsVKpFjtQYvMPYf+PjT++qhYPOJp+0HgCxAaIIXIV9tzBrPx/JP1jK8dp5ByMa
	bVEDhxwKpkX3FLN2LP+eCgN0ypnvZN2zMIb5Di/X0+29d+XHQEQwC8PI543q/muegRvmdSU4w/C
	vP/tDeqXwpVahn9J0peoOAgwunUCUDWI9jBTr99O3ncwZwRse9ESRlMSG+
X-Received: by 2002:a17:903:11c6:b0:294:880e:7ab6 with SMTP id d9443c01a7336-294de7f3864mr32919965ad.1.1761745192059;
        Wed, 29 Oct 2025 06:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwEsDwWs1QAFw7w9LWPCYgWqhftmnYlSsUlFDhkyGg4vLsy8BrHI0EufwcSwEAOD4boLDFwxuOLDJKRkApizI=
X-Received: by 2002:a17:903:11c6:b0:294:880e:7ab6 with SMTP id
 d9443c01a7336-294de7f3864mr32919675ad.1.1761745191695; Wed, 29 Oct 2025
 06:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022121345.23496-1-piliu@redhat.com> <20251022121345.23496-3-piliu@redhat.com>
 <877bwgw9yf.ffs@tglx> <aQAvnjVvJOUx78Nk@fedora> <87qzunuqqo.ffs@tglx>
 <aQH8KJ8RsnzbLfN2@fedora> <874irhvrb9.ffs@tglx>
In-Reply-To: <874irhvrb9.ffs@tglx>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 29 Oct 2025 21:39:40 +0800
X-Gm-Features: AWmQ_bmAiRNWzlkP5Zk2u2zmw0I5s4MaTOTKvx71kEq2S7NjKnYXwC0dF7kEhcA
Message-ID: <CAF+s44SuXgZ4MD5z8m_q-m03j_p0u0RTGhH-VXF25iwQ=Jy-SA@mail.gmail.com>
Subject: Re: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when shutting
 down nonboot cpus
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Joel Granados <joel.granados@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:13=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Oct 29 2025 at 19:36, Pingfan Liu wrote:
> > On Tue, Oct 28, 2025 at 01:59:11PM +0100, Thomas Gleixner wrote:
> >> If you freeze stuff there is nothing to do. Hibernation works exactly
> >> that way without any magic hacks in a particular scheduling class, no?
> >>
> >
> > There is a nuance: DL bandwidth represents a commitment, not necessaril=
y
> > the actual payload. Even a blocked DL task still occupies DL bandwidth.
> > The system's DL bandwidth remains unchanged as long as the CPUs stay
> > online, which is the case in hibernation.
>
> No. Hibernation brings the non-boot CPUs down in order to create the
> disk image.
>

Oh, I see. Since there are no DL tasks in the runqueue, no migration
occurs to activate the DL bandwidth. This approach, similar to PM, is
perfect for addressing this issue.


Thanks,

Pingfan


