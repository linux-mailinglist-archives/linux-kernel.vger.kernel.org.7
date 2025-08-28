Return-Path: <linux-kernel+bounces-789933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED8B39CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9888A7BC5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97F930F550;
	Thu, 28 Aug 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUq7qxQE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF930FC04
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383455; cv=none; b=P6CICeGiG5TR0TSbu3FKLfa48y38puSP4S9UqCkzZmt2HW17QcJHP3QLDAWEqCigc938PBMlySiA93fttxhIzRjYAcdvIp9Pxf1wAwNEcpxAjDUGO3KRi5Ms0XQ8KBxHMyzygH9fSSWToPb4BeUqlRkFIgxSlVs1sunpy4JJUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383455; c=relaxed/simple;
	bh=c8L6HSo/zN3rXMUH3ZqsTsqpBeaIloN4bIJIfK/qhXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap/oW8UU6Zzh+tRlad0+mvVFsxD3gT+Ie1ZzIuimcD4SxNi595soVur8TbZMaS4K4FpwS22MjmsAGVYtqIQ8R1fQfgbd1jR+yUW7ZkITV7XptyMmGU5qeog5axyuUHfWbkoVm1sTSOYNixKCtQxgkezt94062U4s61bs+VFCim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUq7qxQE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756383452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWaOgO4jpoluN2Qx6CVMt0VGgcSixW+/nMYe+GAjQss=;
	b=CUq7qxQE/A7YhDXw68MgXBKi+MxZkLY1zrbqMlmKQOZpa1UdFa6i4jNUGDGSQlq+VyJZ56
	VGbILMZ1EdlVNbPgyKEbYs0xAuxWH4S20J+Yk6c6Sib5YkeKWC5+qB1mB/MgeVLFIc6/rj
	Bz83+EiUstabcLNyob7YIe4+vp9lrfA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-ko2gdAgSMQKj38Nx_q--7Q-1; Thu, 28 Aug 2025 08:17:30 -0400
X-MC-Unique: ko2gdAgSMQKj38Nx_q--7Q-1
X-Mimecast-MFC-AGG-ID: ko2gdAgSMQKj38Nx_q--7Q_1756383450
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afe81959cb4so62215766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383449; x=1756988249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWaOgO4jpoluN2Qx6CVMt0VGgcSixW+/nMYe+GAjQss=;
        b=UoCoIh9E4WFfgJLDZFY1X7XkRHhnUJNGNlXSQRbsgAxnL2I2QFCat0Pcx7+vfOX5Yl
         oxJWVKl2uGFydblSahfWc7fbEWPo2drRiSnUrSG6yLKAuf4OPtKkklr6XL+ly8BWycqb
         OKVh545odGW0K3/lp5oEz5wZykUIeL3vb+pR7a7IsENiXcTb0Ie6b7yW+HG6ZHEnHUww
         l/96cK74kzFghwb4AnKO/5KzT7RR2TnLKMhGA3tqN5cRsD7FvkENvOHgUwefS/BoSnHN
         12OmX/q/7EvmhKnx7c6Hx3Xgc0ZBULsZCN0hyPAs471H9LYCSHvKR/VY9PtFMzktbhGK
         Ofrg==
X-Forwarded-Encrypted: i=1; AJvYcCXaQYJKtOF4RkFtKtS7LVBylaTqH/z3RoTL/xnpLtfjoFFFS45HfHoCgK0evRlvZxB3Fgu8CRUIY3+Qb8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YywI5pYD7hKfoAGHCYP29eUxNTHKK77DNLtqMx0PB/5f9IUkiyd
	enSs8HGo/f4FVCyQ93YwD3K8ssZL97sfUImd6flqhhLZqR9Zzf4BLobHXsDHshHwf2l4n1DJXV9
	JizdRUmEVf1ocG2Inr8BTW6dZF5lgOQMWO6NnZL4BtoBVHOfEU4J+vKZbVCaC+v6iy/Ebs+NIv2
	jyMRwEbaGHY0r9qKXIJYdX+GJnV9JhppT2cPi1xe5l0xUJsK/xNTI=
X-Gm-Gg: ASbGncsqswSmUOlnNdwgiIs6VufZp5JoNpDYo8/ET5aQnL1Idq3NJbwnrXnvkqbrB+h
	N6EE0Ftk3c8CCb5wWQQvJM7NnzbHvZCFfw6O2TPBonJqM+qheNOHQwk0+GsKrdRwPQFZc3n7Fjc
	vB2lgzzez7Dg9DiRLmkaI=
X-Received: by 2002:a17:906:5a8d:b0:afe:9e58:754d with SMTP id a640c23a62f3a-afe9e587a44mr706157466b.64.1756383449314;
        Thu, 28 Aug 2025 05:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC1NApuk3PreLppjRFJa8Sx4eXldlrKGys952/ULp5a27DqEMQZaYlRXXz/vQZczNt3zV7J2vH1LrA1VhXB2Y=
X-Received: by 2002:a17:906:5a8d:b0:afe:9e58:754d with SMTP id
 a640c23a62f3a-afe9e587a44mr706154866b.64.1756383448779; Thu, 28 Aug 2025
 05:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755018581.git.ipravdin.official@gmail.com> <358400afe299a82806e9969570cd3009621bcd8c.1755018581.git.ipravdin.official@gmail.com>
In-Reply-To: <358400afe299a82806e9969570cd3009621bcd8c.1755018581.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 28 Aug 2025 14:17:17 +0200
X-Gm-Features: Ac12FXzIu27PrjYZAW398ij3mtMrwSHWcJpQFNT-nJzeNWxfQFJ1-m0bEKi5keE
Message-ID: <CAP4=nvTfYc5YmzYAoNEw7z4sjFEf3ANa7eFMXfmvp6kGxtS63Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rtla: fix buffer overflow in actions_parse
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 8. 2025 v 19:21 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:
>
>     *** buffer overflow detected ***: terminated
>     timeout: the monitored command dumped core
>
> The result of running `sudo make check` is
>
>     tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
>       Failed tests:  3, 13-22
>     Files=3D3, Tests=3D34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.6=
3 cusr
>     27.96 csys =3D 55.67 CPU)
>     Result: FAIL
>

Interestingly, I don't get this failure on my machine. Maybe due to
some compiler difference, the buffer overflow is not caught. Thank you
for the fix. Since the "signal" field is next to the buffer, and is
written after the strcpy, this might corrupt the PID number reading
for a command like:

$ rtla timerlat hist -D --on-threshold signal,num=3D2,pid=3D42

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


