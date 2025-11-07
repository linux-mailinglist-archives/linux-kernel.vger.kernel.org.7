Return-Path: <linux-kernel+bounces-891110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D54FCC41DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82957351CC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548E53043BA;
	Fri,  7 Nov 2025 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KVYUmF+4"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB1262FD1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555584; cv=none; b=Gtir5Tv/SLogqznHjhYLQCyIosl1318PsHz9dwf3aubwP1+uP3B1BmiKYiMu6dgu1ALPszxfNubSygbBmFOyfiIfzm8PuILpWvV6NW6VossFc4U2mGd4k2j2r50Q8tdjHgcYlbR/J2XNaC6Gz2HkDdpsHBPEzKvTJuw01lN4R3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555584; c=relaxed/simple;
	bh=exM2y4bXCjZMQxm7NJdgWLyhnwqAYQhkw/iId3BFS+8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=DWO9I3+YMKMiErP4EYf7i1ZS57AAb8WOtjxUzjhcIM6shUVibAwQG3US3DwSZyoBtmRt0csPg4/yJeH8H+A1gYNjIR/QPIdENzu9CZ5jYvVmsxtfXnLIwgkwR0DgsrTYGAccYSjMljGIkTlY2yDZVLPnLB3LjTVFpgX8SnMkMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KVYUmF+4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88f8f346c2cso117668185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762555582; x=1763160382; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkmPvv21zjwIVzkW8sxRUn2RFjg0W7CBZpQyks/0r2w=;
        b=KVYUmF+4V85J7wkDvBX3yrVHN5+YA71d5bxsyxqohUm2OmHoZwGu9JWjnf0UhwtVvO
         pW4QIjxXvTG5Ix+VkbzhoPxxUsPK4C6sZa69vVq4BohCiqNBFnYS7pNeBbG2h9J+7HKc
         4qCPr27R6XCpoUPA1rNEPqwZrcYlpC21iUzho/0/oqa3hMFManvilFCpf+iACvMbKxzt
         RMljVYOJXELWE8fQzf8jdQYPtEtofibVTvfb4vJ+P61bX5nDzbDk02HEUhwqzN3ATSji
         io+vgmyxH+Nb+j+j2uieD0odIG+HYtwb6vXjj03Oj2ucT/sEVYYDEpyFww+eEHsy/Dnw
         SVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555582; x=1763160382;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkmPvv21zjwIVzkW8sxRUn2RFjg0W7CBZpQyks/0r2w=;
        b=h9+rspn7hpnfECtJiq/b+thV5X+NAKM1Nw3F1V2inXa6eRL5Kmuw59Ec85N3Umssy2
         DVmA5VB+QcaVL4ePJr3pr/DeOkSV+qhD6fNj7Op4JohCtC6or/C6glBlg1C7fVzN3hIE
         Qx+GxUYumtTMBp1LdUvRcenVEcAPvC9mYezmqwPruFDHONSYWCGtMx43ZCA0CAekjA6s
         cZK8C7IBGrNNV/7iViR52T4YE26Baw7iYOC0IaWUFs42YOv7q02zdld2BQbh5lU0Qkhp
         5YJGkgzrkWOMIql9AiZEPzXOw8ZSuP1WrKGAlnNqxDxJD3WyQcVX7wK0sFmO8O3eCF0Y
         TGBg==
X-Forwarded-Encrypted: i=1; AJvYcCU3jLAL1V1hGy8jNMeGQ8VxamffXbQzJfLxkDbN2CciXdPabspBJqGpCJzzT6AoCI9DW+dhKbBkRukOqLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAh8XETz5w2Wwi1udl98aIR9UvtBWGR4nvhDHjI/xBX2yz90dw
	uEjlnVDRtA3z3UXiGwCNUqFl2SI2vB7ISMX5YoNPjncgiqFMe9g+uHpXlzyaUNRuOg==
X-Gm-Gg: ASbGncv65oLvqr5I3kD4GejR5UtW5VSItBv3oZgs3rCqr3VH9S627cj/iVRdcdfe7Bu
	RlXoQ6SzcJBbjRH7SlZ8Yn7m2Tu2ywfpNll5bkSnmHbEzl5GeXvWqSXtMvTT17bU54woTzyKfCa
	MmstD6bfAf3giAgDUa9nhc2Dx+tPPBKllszNOP99BUP/xYB47it20h4ug90FPFUlqU/5oNWhaZJ
	ZbbxZdK6+paK6xFgTzrqtZSveO2kBoqLhaWKvGj/uLmg746pKu6y22QQXgOp4xIuDM92CnCoJIA
	+1PY7GDj6nN20RNAx0Wlt9twTo47Os1QTy1vJFL56gyM87E9vt3+z+vY0v4JkdOlRlgBRjHEoob
	bwfEnvwfmBCZzUPnZZleg2Mt1T7aYJnFgickohrSX7YV4d3JF+JotxB4aS6q7G12p7GqhgW3Pwc
	d0w9Vt0Dn+heU0qkYMLG8xoTfWvZdffNAcVUtd0ImZPOznyo80DEro9+hG
X-Google-Smtp-Source: AGHT+IGW2w5cYMyEJm74NZs2gDmZaOfaiPNwFh5FQ3KOXZnvYLTWQ2yOy1B0NxEYIggNl+tUwAUNgQ==
X-Received: by 2002:a05:620a:4153:b0:892:8439:2efa with SMTP id af79cd13be357-8b257f02acemr121709485a.23.1762555581926;
        Fri, 07 Nov 2025 14:46:21 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c334dsm512663685a.12.2025.11.07.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:46:20 -0800 (PST)
Date: Fri, 07 Nov 2025 17:46:20 -0500
Message-ID: <a396108e2b9f19f0c453a44c8e7be873@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251107_1632/pstg-lib:20251107_1737/pstg-pwork:20251107_1632
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Cc: eparis@redhat.com, fw@strlen.de, pablo@netfilter.org, kadlec@netfilter.org, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH v5 2/2] audit: include source and destination ports to  NETFILTER_PKT
References: <b44ec08fbb011bc73ad2760676e0bbfda2ca9585.1762434837.git.rrobaina@redhat.com>
In-Reply-To: <b44ec08fbb011bc73ad2760676e0bbfda2ca9585.1762434837.git.rrobaina@redhat.com>

On Nov  6, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> NETFILTER_PKT records show both source and destination
> addresses, in addition to the associated networking protocol.
> However, it lacks the ports information, which is often
> valuable for troubleshooting.
> 
> This patch adds both source and destination port numbers,
> 'sport' and 'dport' respectively, to TCP, UDP, UDP-Lite and
> SCTP-related NETFILTER_PKT records.
> 
>  $ TESTS="netfilter_pkt" make -e test &> /dev/null
>  $ ausearch -i -ts recent |grep NETFILTER_PKT
>  type=NETFILTER_PKT ... proto=icmp
>  type=NETFILTER_PKT ... proto=ipv6-icmp
>  type=NETFILTER_PKT ... proto=udp sport=46333 dport=42424
>  type=NETFILTER_PKT ... proto=udp sport=35953 dport=42424
>  type=NETFILTER_PKT ... proto=tcp sport=50314 dport=42424
>  type=NETFILTER_PKT ... proto=tcp sport=57346 dport=42424
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/162
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Acked-by: Florian Westphal <fw@strlen.de>
> ---
>  kernel/audit.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 4 deletions(-)

This looks fine to me, although it may change a bit based on the
discussion around patch 1/2.  However, two things I wanted to comment
on in this patch:

- Please try to stick to an 80 char line width for audit code.  There are
obvious exceptions like printf-esque strings, etc. but the
skb_header_pointer() calls in this patch could be easily split into
multiple lines, each under 80 chars.

- This isn't a general comment, but in this particular case it would be
nice to move the protocol header variables into their associated switch
case (see what I did in patch 1/2).

--
paul-moore.com

