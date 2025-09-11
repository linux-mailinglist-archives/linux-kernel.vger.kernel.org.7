Return-Path: <linux-kernel+bounces-811942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9FAB53078
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AF3ADA67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E48313529;
	Thu, 11 Sep 2025 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmwifNqB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB1B26563B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590345; cv=none; b=VviXJVnnix04ersvSUG9HqGMdovpqdXv/rb7oR2QutwGqQgUdNkZyiAwCYMerkRhsLRQyzKmq0vTrRFig6mycVQDh+s84nXSKo/QV3k8HBfQzDuVccB5UP9Gp0A/CEearpKe9+Z3QaXrkIukmyWjnBDrFxz7vRE3/THNVaOB5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590345; c=relaxed/simple;
	bh=vU7YIeqeNnP2WZniRMFC46l0QlmEBf+apmlt516M9/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKTcHqm3TS5OOIBy9wDCIhLCQxhhkehX1gcujIUrbgxvT+7VA71mMI2PuEZgOHizf9dMfDPoEEBVuVOcb8/0p8J+hizxWb0OAS+Ha6nZ+ORZUTmX84CinK0ycJQTu0zRpNWSlcSEdx5vh3K5rTut21AyG6MzpkER0nSXKVexwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmwifNqB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757590342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uv9xgEOBHqilZta2Ov9hEM6jLUDZQaOycayp6o0rFY=;
	b=PmwifNqBFpy4/TePEZ4gnZgi6A2Nh+JZ8yX5468GStofLmUxSxot9rcj3f89dnuE4LSAhj
	v5schqtiO4WoPFXrPmtLowHXhItwl35u9Mxa9EFl1rgXK5I8v89e5MQMOv+yqkmKEiMEsL
	bKcluwdYbawe4g2rDBqj2A+7JfxY0PE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-RaTI6hqpNcGHy4aMapuS6w-1; Thu, 11 Sep 2025 07:32:21 -0400
X-MC-Unique: RaTI6hqpNcGHy4aMapuS6w-1
X-Mimecast-MFC-AGG-ID: RaTI6hqpNcGHy4aMapuS6w_1757590339
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b04a302fb7cso62760866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590339; x=1758195139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uv9xgEOBHqilZta2Ov9hEM6jLUDZQaOycayp6o0rFY=;
        b=AvMnwKwMGhtMYQSi3q7OK/x17UAboVI9v9Yuaj6Oh09FVAnx4FR7vi2R4Q9aXV8crK
         Vuxp5tOgU0ZkSVTqYBz4Z7GjBA95i+o75eqg+xongEdYMn42nP1thYS+xIVOnwKjrwld
         Mf4o1n+b7qZsr92mpELD9Zplrm4LrsObrCkKV+pHw4d2DX52hbPFysINaVELbQDSSepk
         bTgyvdMfxAwnKsH09CV+IAvVjSQT/7jl5Kn741UpSyz8aE3nBVM7oKV2xdx9MCUik7Jc
         kUxE44NY38jqkBSqAQ1ho272PsiL7/8DIhBvH08HkNZTmFE7VtvaYyRch+6vjt+hmetr
         PKZA==
X-Forwarded-Encrypted: i=1; AJvYcCXZMu7anD6q5aq2w57WNIZ7GFTroLj8DVVB7ID59DL/AoE/YOfjpPhZb0BxgwM/N6ccfy/FLkau23iHEyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3eDBA9R4PwhwOAcwaDXS9IYTRV1pzFWN7ZpsA3EunBGmdAlpC
	2T+c1VvzBP0g5XasWwMUwCjZdpbQSPfM5OtsnTigygmja1e22Gv0nJ8BK2qzDXX873etYNx+cY+
	tjti74pLIaDSGOBSR+2tatOmsR1Y8h5A7704i/sNWZ6VgivVFVKBaTuyyFPaTf3/UWhzUsxDmJn
	3DaOs6RL7NlQrPsB2FTNrsSyZzuFQDSf+gdtoAN5f9o7hKVaeXzjI=
X-Gm-Gg: ASbGnct15Zf2GDpxwliZ3n1JaJ01UFXSIJpOV5N63ZXqMDhum9HnY2Czy4At4mekMIT
	ifivKz9aBQWfMtaEohqqFMqdPjPe9oX3PHOxMnFgRRIJxk5ezXjXxIZUJUTE34tni/FKzhilp2r
	52Fo1fXTPBwQICmo9kBPI=
X-Received: by 2002:a17:907:3c8c:b0:b04:59c4:d90 with SMTP id a640c23a62f3a-b04b16dec24mr1845700966b.46.1757590339223;
        Thu, 11 Sep 2025 04:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtryqqhK5XPWAJhTYmS3Rl3cuFSHJKIBlPP4B+UZlUQID8WzNfFKtrFMbWlVE4yUsMN7bd8dbWKx+GhAt6xWU=
X-Received: by 2002:a17:907:3c8c:b0:b04:59c4:d90 with SMTP id
 a640c23a62f3a-b04b16dec24mr1845699266b.46.1757590338837; Thu, 11 Sep 2025
 04:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757034919.git.ipravdin.official@gmail.com> <e4a61cf3416c9b2a2c4952cbc93b4b05a7c3a37e.1757034919.git.ipravdin.official@gmail.com>
In-Reply-To: <e4a61cf3416c9b2a2c4952cbc93b4b05a7c3a37e.1757034919.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 11 Sep 2025 13:32:07 +0200
X-Gm-Features: Ac12FXwHkQLXa0LpbeudjoMzTGDDC_VEcWtyIxBvhBzukc22YS3jY0V4NabCWWU
Message-ID: <CAP4=nvTWmoZ8FvoLJK6R4ZJ+LW_4pp2WDcKqBNBt7pLjVfL0zw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rtla: fix -a overriding -t argument
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 8. 9. 2025 v 4:06 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> When running rtla as
>
>     `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`
>
> -a options override trace output filename specified by -t option.
> Running the command above will create <timerlat|osnoise>_trace.txt file
> instead of custom_file.txt. Fix this by making sure that -a option does
> not override trace output filename even if it's passed after trace
> output filename is specified.
>
> Fixes: 173a3b014827 ("rtla/timerlat: Add the automatic trace option")
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>

This part is good, the only problematic bit was the clear_terminal stuff.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


