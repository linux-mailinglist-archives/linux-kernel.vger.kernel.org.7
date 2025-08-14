Return-Path: <linux-kernel+bounces-768253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA1B25EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64281C281A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795022DE6E3;
	Thu, 14 Aug 2025 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpbfW8Lp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49059291864
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160245; cv=none; b=VA3HoA6gnAoiRjsLMtleQicXY+sZM3LiVYoJqHNdZBcdM1BqEJcQSnwPjsfNHJfWw9yHm/hyxzm9QPIxO4RuIDVJ7B/UFt0w1Wms0Emvd1GiKKII62O742gLccOVnA/3TMvMhEuQqWDeNyctW6aFM7sKnN8dsxyVfayAEYJ/5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160245; c=relaxed/simple;
	bh=TB/E1noUxWzYi0v4Smf83lZULir2DMF3tUNw+Z205jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5k9I+77R8TC+DFhC93iqFPKaFCeW9GHzeR8tVXjrdiU90eB7NVR4HMXosfhjSpvolvH0P0a12aRDveYKCIquoWPRuFBwYUiyggYUwUpE+f37UYBAFrpon89Gh9FhGAmZ2TeHTJpCiNRCRLClqgLIkI4HAqcMYXZ08+nkQJpsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpbfW8Lp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755160243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=enHOLMv+2lYLRG7BYS96zrnwJYwok6Qf7P1AZ07Xgng=;
	b=bpbfW8Lp+7uJW8+6T6aqEvEl70b6SRhT7daKoDh4f5jXNvfxOAZTSomQsn9SIFkUm0d1QH
	G/Qu660OYYFNsJZG8WQOgQM4beyr1zP3tvPg+PKMuA67yqg5M82yt0QaiV0SFAQxd4zDCN
	nL8IK06+wGuHr8kQWMmc4WoclEkwJBI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-KwUGnpvfOe6MvNIox2zzYA-1; Thu, 14 Aug 2025 04:30:41 -0400
X-MC-Unique: KwUGnpvfOe6MvNIox2zzYA-1
X-Mimecast-MFC-AGG-ID: KwUGnpvfOe6MvNIox2zzYA_1755160241
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870646b11so155216085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160241; x=1755765041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enHOLMv+2lYLRG7BYS96zrnwJYwok6Qf7P1AZ07Xgng=;
        b=weAuzyV07s86OANTNnV/hWQtzjrw2zbxhcFxGXCMbUmytDDrbdqKQPb+Vh2TOcM9iP
         cHjYn2FCvmg2Z46Vd2Ac55AvlcjlOmdmpYlgSDx9zL8seGr+IRI1cdYgggDP8Voi3Avl
         evT8KcbiImFYenQC8B0Q2wNoWakokGjHwyG32y36aeIRLBOfHheGaTEMALgp5BErN4kI
         sswMLtfXjCn4aG/0lHr/bH2KU4aDVkVUvRlBi14TOO3PahI6MyFjZOySnIdd7FyOMxda
         rxX1rdBX24gnpsvCfiiHipGiM/OUy8XuVpQWEIrIWk9JrGx9WkXgMBhcTBNZzIL6p/L5
         fj0A==
X-Forwarded-Encrypted: i=1; AJvYcCXsbTqz1GNYvvLmH3ZC3+luP+Lwl3D3nHewUKQqxV5C0uBhfK2h5j7d7R8wmWehACOjYY5YxVwbR8dvxwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHC+ptzPhHsoWbHbDwAG698H5mbupyHN5awM7UMeBji6OODjQI
	zFV58bBsppbhewtLo+Jfaop1BKXDQhm31p2Nj4el1vwxHfxZqBSKNTrli9aCYMPXUH/OjyJLMK/
	nji3ahW5qiJ9/K9MBKxi+RliDMboirJ7UEaKodROQgoD04VapBUNC6C2jNOIh2Da2ZA==
X-Gm-Gg: ASbGncvfCmafVRH0dAa5YdGJsMY0jh/uTKj+z33SEo2Pf/0qYngXo8ue7Nsozcydnlw
	2kbvTOjetnHkzNXZwb2amKpRYd8p718XiiPbDHF36wIib2SxLsRbEzpTHkc4TbEmUeDIAnf2haC
	vNCXJ3NZrEHn0K/LENr/xZeBcYGdHARBU2bCLj0g81YmlODkleeKZUc01XV/ZUkbyml+tD/upHD
	zUeExARqTf0vW8JQFauS8MmXTU8Hdt3sgDUELKsseD217DkutOqY7JHYstpyYT+RXtG0hiMnIxN
	r3tUv89yWvolfTo3sjCUgzU74Hika/X21spU5qnyJWGBKKLKOfr/sAHmkdL41q+HEm8h
X-Received: by 2002:a05:620a:4304:b0:7e7:fb31:b1b2 with SMTP id af79cd13be357-7e871bade90mr196079585a.64.1755160241079;
        Thu, 14 Aug 2025 01:30:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBD3j6NQkQFdrQqxPm7cD9Tc4kh5xzibeoCZ39ua5YedfYy5xYDGmUQZk6KZcCdfZ8ji+9dA==
X-Received: by 2002:a05:620a:4304:b0:7e7:fb31:b1b2 with SMTP id af79cd13be357-7e871bade90mr196077285a.64.1755160240701;
        Thu, 14 Aug 2025 01:30:40 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.34.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82f5fbe48sm1097339285a.56.2025.08.14.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:30:39 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:30:32 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v2 02/25] sched/deadline: Do not access dl_se->rq
 directly
Message-ID: <aJ2eqI63i5MBkV2W@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-3-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-3-yurand2000@gmail.com>

Hi,

On 31/07/25 12:55, Yuri Andriaccio wrote:

...

> @@ -1667,9 +1668,9 @@ void sched_init_dl_servers(void)
>  
>  		WARN_ON(dl_server(dl_se));
>  
> -		dl_server_apply_params(dl_se, runtime, period, 1);
> -
>  		dl_se->dl_server = 1;
> +		BUG_ON(dl_server_apply_params(dl_se, runtime, period, 1));

A WARN_ON(), with possibly a recover strategy, is usually to prefer.

Thanks,
Juri


