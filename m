Return-Path: <linux-kernel+bounces-880285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C222C2557A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E134642D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C8933F363;
	Fri, 31 Oct 2025 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLZPp2ww"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0F309EF4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918556; cv=none; b=PYELjc2LVO70nKaWPXlnKTSrmYPvyZHK+EWCFlE6KoHtYo5uPsbWdkxpyQFyK/XQG48ZxbLIKnWLIabQVsSjEmeMaoEeoJxZDv9cylHQ3O3Dya2DAB9jo4At1eQ7Xns7XKjJiSqwEXgSSykRJldC4A3Dz6kavOejniZpIejIxj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918556; c=relaxed/simple;
	bh=otBBx4wfl85EDYap2Atk5K5Z77gwvTZrcdqKjrD7Hz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6TOcfAzP9QQ5saFFE/niyaNp3mW8S+zyT9rK+cFWOdtZBa0j8+F5slSe4vQadLXNDZtaoj293z7thZ5ewnJ2frpMnnx4UmT0Ev4t/nmWMbqZP1c7d1mnStrLD5B+JdS3FkSf5vW0l8mU+qsPbhJIsHnPn8Pnq3qBaW0B+jjrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLZPp2ww; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761918553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otBBx4wfl85EDYap2Atk5K5Z77gwvTZrcdqKjrD7Hz4=;
	b=aLZPp2ww3oLg36v4AekKT+0jKh/end2+LjdyYjD4V8HGTbtQ8zLsC+DBENYQCqeGyxzMOO
	9FIq+VySnJpLTj87keUKCPu01pKNsgTkEsf/sQ05K3JVxo0BbBbSsJPQN5ElkkibnLG585
	M2LSpzW61gSxptuQzYd8D+Cm4uJ8/tI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-rEigt3KKOGKJaKJNGsFskg-1; Fri, 31 Oct 2025 09:49:10 -0400
X-MC-Unique: rEigt3KKOGKJaKJNGsFskg-1
X-Mimecast-MFC-AGG-ID: rEigt3KKOGKJaKJNGsFskg_1761918550
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87a0e9be970so62890256d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 06:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918550; x=1762523350;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otBBx4wfl85EDYap2Atk5K5Z77gwvTZrcdqKjrD7Hz4=;
        b=HqpcUXMyIXdnYE7nGKZ4yY27vcggN1WI9J40FiFwCJnQE6xaU+gy0M3GqrP59OZe42
         zzK8cYL/B9zUTvCeh0WHgwaVK89RWFZC9dgRdiyzpTkYr4x+0O4szjX35AqhT168Ayid
         dR6g4aHw4lWdL0auKuCiuthPNvyzrfKXNMcuFwO+kpsLVDWV1Kt+RyqxuAO4HOsZico8
         HfgsvXQnV1K92TjEn3HPrp2ixlfXldQXFdRInzng1Yxu0lRxEpBVi7cw1nc7ApCXuUIM
         AKwgZh3rVY7Z8I5F/n+dm30s/9XlvmW94w+fQ9Ulbym0lZMf9M9nx5pzads+By6WcGzb
         AAwQ==
X-Gm-Message-State: AOJu0YzERZRmP0lIYjnJZozJ4WQ0dIs5C6yhdtobEbpM1xlC8RfpFrzK
	Kw+NNDVUkgdBHbeECjsjgdbvqg8ATWkM9VcNO3a2SU/MuWMrq4Ec07yFf37HtA3Znsnsn9PAJFg
	0J9TWIOOiZ35F4zNPX9Ij42GjlP49feG2P5t08XoeLJX8QJoHnEezUGw8gDbmmj76Zg==
X-Gm-Gg: ASbGncvqBmQmIc6TmKsbmXXCOu8d1Y0XuH8VzkqTxwKLVIaICp1lNkFZZFElS7nTMjF
	iV2fyMj5JwkUEo/AaDS5UCbP6KybphSOuwHZs0JgMii2fpsG8HrVCMjc1+fpcvnP8/RI1GFQzUb
	f4ApEYv0/9oQajfNhmRxCDDVRWL434jCZWeK5QHowpSKwHD138RYwZGVUEh/R99ZmF8Cj1FnK+7
	SNuTTa2Gm+cGzVC0HTMoqfhrXRctjhr3I9E04Bii7LYsbDcn61B/zCjtfpekrFbjcmtuSCgcW4R
	/GnDtmJHaBsOShZ688GZfzOQJ0veRs6N/HKjVzEU0HsHxpmbHs/L9f5oExZyAB0xEkCkvHO+s8m
	Zi96gcA5c7yZSYiAvY5haeXKqjh0jgWiy6xGWpUmqyYOBQLTnidZlvkDxk6cMzMLg
X-Received: by 2002:a05:6214:29c8:b0:87c:67a:ca69 with SMTP id 6a1803df08f44-8802f521df4mr38809416d6.61.1761918549815;
        Fri, 31 Oct 2025 06:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMIRsRVAV5K6QvCw1eHulx31J7vhSYenLFXxOs2TXmvIp5Ub3MJu5pl3+ly4k6nuAEmbzZzg==
X-Received: by 2002:a05:6214:29c8:b0:87c:67a:ca69 with SMTP id 6a1803df08f44-8802f521df4mr38809106d6.61.1761918549454;
        Fri, 31 Oct 2025 06:49:09 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880360ffca8sm11630206d6.27.2025.10.31.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:49:09 -0700 (PDT)
Message-ID: <a0e34d41214dd6d98e3c7b7ec37be7ad0e1812e0.camel@redhat.com>
Subject: Re: [PATCH v3 0/7] rtla/timerlat: Add --bpf-action option
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Fri, 31 Oct 2025 09:49:08 -0400
In-Reply-To: <20251027153401.1039217-1-tglozar@redhat.com>
References: <20251027153401.1039217-1-tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 16:33 +0100, Tomas Glozar wrote:
> This patchset extends rtla-timerlat's BPF support with the option of
> executing a user-supplied BPF program on latency threshold overflow.
>=20
> See the supplied example and documentation for how to create a program.
> bpf_tail_call() is used to chain the program with the built-in BPF
> sample collection program, if the threshold is hit.
>=20
> The feature can be used for both in-kernel data collection and sending
> signals to userspace directly from the kernel, if the kernel version
> allows it.
>=20
> Note: The patchset will have to be rebased on top of [1], or vice versa,
> since they both touch stop_tracing() ([1] adds one call of it, and this
> patchset adds an extra argument to it).

Probably best to add an updated version of that patch to this patchset.


> v3 changes:
> - Add tests/bpf/bpf_action_map.c to test commit (forgot to run
> git add before).

Might be nice to build that as part of "all", for the sake of people
running the tests directly (FWIW, I still don't see anything in the
makefile or engine.sh documenting how to satisfy that dependency).

In any case:
Reviewed-by: Crystal Wood <crwood@redhat.com>


-Crystal


