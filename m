Return-Path: <linux-kernel+bounces-733666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0668B07798
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24E73B4885
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A1A21C188;
	Wed, 16 Jul 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFitWqS5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC91E8332
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752674845; cv=none; b=nKHJrvdt4jPfC7P3Qi17V5deyfUlkq3NxrHftPKFfYeYLzhhU5jFMHg7zJ4O+dXJNcPL6/9LxGtYjg6qWeQIHNfxUiyVW4oJ2fTa2qeCiifpz2w7tO6slaRexGHknWR/JV+U0dlddnNslktsMmJDGS5dZOqWFDogfOt/OSAPixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752674845; c=relaxed/simple;
	bh=tB2hd0yWjPoO6MlhQbxYZc4V8AzKcbCfWKCdItp3044=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSd7yYTxlb2kEVv6bUaiT7D0bO68twkd8LznOqJVkjdmsXoI4U6B0Adcg7us1c9vHghCSlxHX6dl4q73DpRTvrfDUJFnyrtVRHdpk4H6I8nha9zShCPGhq/5jGahKhsf9V9LlIuNrXZR97l6rqWTTN6j4ZbK6O/vmauGdz1umQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFitWqS5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752674843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tB2hd0yWjPoO6MlhQbxYZc4V8AzKcbCfWKCdItp3044=;
	b=CFitWqS5l5frQBMEsHrqg9jnDwvvkkwRRt2NbotO+EXwYUlgqe0CrEvMHzPu702uCv9fUX
	DiOcT/H11P/sbh4C0gh6F3m9E9F3dr/B3Z78rWW+m9PbTNgoqBwWYCDhzT7QpEHT/nAFNO
	HOjkW2x9ocgU/3DRxluqLrpWaqCoT1s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-RSrhnPlGO0au09Hal-_hpA-1; Wed, 16 Jul 2025 10:07:22 -0400
X-MC-Unique: RSrhnPlGO0au09Hal-_hpA-1
X-Mimecast-MFC-AGG-ID: RSrhnPlGO0au09Hal-_hpA_1752674841
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so509143f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752674839; x=1753279639;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB2hd0yWjPoO6MlhQbxYZc4V8AzKcbCfWKCdItp3044=;
        b=pWdWEUATKtF7IKwZ6gg0AflpL4yGZrPXN0zqbOanDyFJPPM/fRK8vPojw9yh7vzFKj
         8js79/YBaRRqWRBiOy/3rMRFYD6kKrZA6Q7HaCMEVXno0zjKMjIckv0cbTEwPYQH2et/
         zKM6Zmlu+N87icf0ppnktAbj84d9HpNbkyZmkPuW5tbEhsrrGljMmspo+9ydaQkrNh7y
         +ltDbkCOkX911PTP4bdCTdyJXgXEwMTWpQ7uT44uEwl8BOG9tzguCPzNB49N+ysKmfzr
         AI2tPHuxMkUlSfnwla/IR4fHe6Zm0sCDB6wfkQLUSJRurzhtUR5u9gMdyM/8vFCW2QrR
         bvzQ==
X-Gm-Message-State: AOJu0Yym6UDGrLs3OSb2G8EAOsACvMvtabBvjtIhYT/3J97JCbwBXxFQ
	jQAchtWTOKuz4LJ/Ba5dhx6R8JJH/9WmpUuP7dolR6XYjd7aPdnyLQqXUYr1bp9lmW/tw9gA57t
	a6/xeD+gtO0/ZdO4vCmnNV6DpuOZF46yU79MSuK/BMolWGYCmjgFl7J+6THxwv2ryIA==
X-Gm-Gg: ASbGncv34YiA71yvsnQUvcnUK9c8GMqbo38+EtK60jtZCMX53j8M8hc9JK2G5X6Of82
	WDnYW1edeMIl5rE/XJKjUBUJ2nVSHojL2fyuqxHityxu+QoqId0liDUO9LPyI5RFWD+tqE0zQQC
	yBteCsBnDAmMQ2azJMmX8CMqU1InCP61j8jVHC0MrQh9GAppQb0JYibpGF439Z4IfxCIvfnR1Am
	Qom60+306Nyp61y6ookj78Q0c8YiZHB0CltdLEN/gZZfuDboeprx0pKbepeixxvGQcA5JzBDvo9
	pnb51RCQhlrttQI0evzN6Y/69w1PJBpo/aWtUHsHSiyP8TdNmfuHkqJZU25UxBd9EQ==
X-Received: by 2002:a05:6000:2b0c:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b609524369mr4320863f8f.12.1752674839401;
        Wed, 16 Jul 2025 07:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMGLnEBjMAuOVnncL9pST+yEzGrrXmlW5O5822Ksx735cKfIpDH13N4slQf+5+QbAygFGD/Q==
X-Received: by 2002:a05:6000:2b0c:b0:3a3:70ab:b274 with SMTP id ffacd0b85a97d-3b609524369mr4320828f8f.12.1752674838921;
        Wed, 16 Jul 2025 07:07:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e83e1d6sm21934665e9.35.2025.07.16.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:07:18 -0700 (PDT)
Message-ID: <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 16:07:16 +0200
In-Reply-To: <20250716134513.GB905792@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
	 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
	 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-16 at 15:45 +0200, Peter Zijlstra wrote:
>=20
> I'm not sure I understand the importance of IRQ state when describing
> task transitions.
>=20
> You know both:
>=20
> =C2=A0- schedule() invocations for any one task are in-order;
> =C2=A0- schedule() invocations for any one CPU are in-order.
>=20

It's to describe latencies, which is the original purpose of the
scheduler model: if the event supposed to wake up an RT task occurs
with interrupts disabled while scheduling, we'd need to wait for that
run to complete.
Now to be fair, it doesn't really matter whether that call to
__schedule switches or not, but always having a switch event simplifies
things while modelling.
I can rearrange models like sts (added in this series) not to expect
that.

Thanks,
Gabriele


