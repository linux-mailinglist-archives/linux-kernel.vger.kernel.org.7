Return-Path: <linux-kernel+bounces-722067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C32AFD4E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7601F3B8E04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5702DAFAE;
	Tue,  8 Jul 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS7GnLSg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6282BE46
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994553; cv=none; b=duYZ0++gBes5sQ8aS17+dOEvQHQLJ3kQzVno5tQ/M0MOORuy0TWKLm+cKmafST7iyMVm2lPFu7C1vEPXFK/mjFkZcJOpjwV0nJx706cQR96bJ8gAkyBtH9BGFSj6lnO2Kx8TezurKUvybXBSstUPaq4RsQ2024ls9s2G1MOt8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994553; c=relaxed/simple;
	bh=H6GKyy+LkHt9Ts0KAJJZWvPhz44BXO0Yp7vqgaoYxEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R8KOMdcP5BDRQ8trnGJmoH6+LFvZoOD0D0gqv++KOR2kh0q/eci+6OcYOHPARY78IhfDHYSbvnkEu6siGw9Y9T2QKZY+Po9XCTh1Y3L8VFGcQEMkIX8e3ADK7ZQbdgeUQ8kyJ/TCO1Xilmu8keBQgYD8uvY2zhc0uRMgskIxdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS7GnLSg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751994550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6GKyy+LkHt9Ts0KAJJZWvPhz44BXO0Yp7vqgaoYxEg=;
	b=IS7GnLSgybCE2CbcmwRz7tmpanBpUU57f76vJSM5ghzxRqRlO7Qz2BhJ3ChWUopUhfmC/b
	oSLRgD8q3Z+CT2+Kg/Y7XZj0oTpXZAW3oBquEp15xmAerov/MWFmRIGka1gGdHqJtJRtEJ
	gMbErpjvGcOUMXVyqXatQEmyA4RbOM0=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-vqwXD5GLN3mRb26WPeVKnQ-1; Tue, 08 Jul 2025 13:09:09 -0400
X-MC-Unique: vqwXD5GLN3mRb26WPeVKnQ-1
X-Mimecast-MFC-AGG-ID: vqwXD5GLN3mRb26WPeVKnQ_1751994549
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-e81d151012cso4999478276.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 10:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751994549; x=1752599349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6GKyy+LkHt9Ts0KAJJZWvPhz44BXO0Yp7vqgaoYxEg=;
        b=PSu9jm+QGDcJLc83Bl6KHoZydZMXaxCsufvghh4CeoaM59c/TYon/jdIPU0APuNVVq
         9w3mKtlYWI5vFXuRTnKd9Vv6LqO+HHZeZSpEbwuRHQmN3dEIF/+sL7DQNeJCvTNDNCLp
         BkG9dTtrYTm9+NQGlFwjlQU30p/cj4Kvj6jFtTZevb4ZnWtwZM2CV1MOCrHJSFMXxVdi
         cWPXRXoWJeV6EJOfSt++bvbOtraXmEEuhWhxzHxwlUKL4HQsellKIR9rPySlkEWYrX3i
         Lyyq8tRRuQAjCVDY6ur9jArJU9H9mCioiPUq5SiJEaf2A1sCXKoExo4HoQx28//z1wYO
         bomg==
X-Forwarded-Encrypted: i=1; AJvYcCVw4JpYhj8ZmyoUfc26qEy2Pq9jdOhciqA1+gqyrdlFjv+Vv+g1BRUvjnTfilyvHVA+6jYfkWosIcwyE1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GXJYZQox02ioU5ICs3j+7fHrHR+F5p0Z3VxxibF8om3GckG3
	yZxXD5OBbHS7jdJ0XwchEX1boPQJpSqZQ0lFzabWkUJnEh1y6eVDjas3Qa+gm0Pk3uxOGn5wz4h
	qMrON/Ha9Dipc38DEvF+rUyWcrJmBTSZci7BunXh4d+2oH3vr1qma48+DzopPwNHEeQ==
X-Gm-Gg: ASbGnctXeS1FuhguugT37uhYCLUDPq+Gw1xHMkSTXttWE/wEdUusxD1dzbwDWUlaH69
	8Op43pifdtm0Dd8WT/ZAOeawYqPDCodOhfEFf1kTL/iEvUN/FW5to6SoyZip4wwTbDhnOaieLQ7
	9N5jgXHnqqiWDoKn8YptlnHWiTvjZpXcllyg++xj3A6EJxUZQbtYtt/o2FCPo7FeRfsRyZOaD2s
	7nfzpa2hWWASZ5XuNyfOV37qfjweiYPQOSnKXbQO5jwwRq+QewuU7dpwK4erOHLRwTkR0leXLi5
	SvV4C/AnCICmDdNsMFshNcW1Oq9mbDObXynu/kLKx8vUXjNgNqZTSIe20Ia4bXAp1Fmvq3P5
X-Received: by 2002:a05:6902:18c2:b0:e87:a1fa:3247 with SMTP id 3f1490d57ef6-e899e19ce85mr18420309276.36.1751994548652;
        Tue, 08 Jul 2025 10:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs2nIqlA/XjsJ9BBEjIAiIfZc6drHzP66CbQlGWFLPD0PMyd3cSjQCFW3gOdhgAzsRrexePw==
X-Received: by 2002:a05:6902:18c2:b0:e87:a1fa:3247 with SMTP id 3f1490d57ef6-e899e19ce85mr18420256276.36.1751994548235;
        Tue, 08 Jul 2025 10:09:08 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c44066asm3408792276.28.2025.07.08.10.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:09:07 -0700 (PDT)
Message-ID: <e5afbff5d8a0bb6448305a3f85a51e3772852ef8.camel@redhat.com>
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
From: Laurence Oberman <loberman@redhat.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 djeffery@redhat.com
Date: Tue, 08 Jul 2025 13:09:06 -0400
In-Reply-To: <E38B4D1E-C7C4-4694-94E7-5318AD47EE1C@redhat.com>
References: <cover.1751913604.git.bcodding@redhat.com>
	 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
	 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
	 <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
	 <a93e72cfc812a117166c0b20e9cca4e5f8d43393.camel@redhat.com>
	 <E38B4D1E-C7C4-4694-94E7-5318AD47EE1C@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 13:03 -0400, Benjamin Coddington wrote:
> On 8 Jul 2025, at 12:50, Laurence Oberman wrote:
>=20
> > Both Ben's patch and Trond's fix the failing write issue so I guess
> > we
> > need to decide what the final fix will be.
> >=20
> > For both solutions
> > Tested-by: Laurence Oberman <loberman@redhat.com>
>=20
> Thanks Laurence! I think we'll leave these two patches behind.
>=20
> I'm persuaded by Trond's arguments, and along with not needing to add
> the
> workqueue helper, I've properly posted that approach here after some
> minimal
> testing:
>=20
> https://lore.kernel.org/linux-nfs/6892807b15cb401f3015e2acdaf1c2ba2bcae13=
0.1751975813.git.bcodding@redhat.com/T/#u
>=20
> There's only a difference of a comment, so it should be safe to reply
> with
> your Tested-by there.
>=20
> Ben
>=20

Thank you Ben and Trond.
Confirming that this patch works to correct this issue.
Looks good.

Reviewed-by: Laurence Oberman <loberman@redhat.com>
Tested-by: Laurence Oberman <loberman@redhat.com>


