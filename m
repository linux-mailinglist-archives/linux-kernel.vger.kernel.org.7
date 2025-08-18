Return-Path: <linux-kernel+bounces-773111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4F9B29B97
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660D03A76EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A34E2376EB;
	Mon, 18 Aug 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmKpTFJZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28918277CBF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504178; cv=none; b=nBoQRSCeMyDIWUdNf6yAtIBn/wBWDTLDV/R6bNFKk3LGltuA6Ri4jStbsRs/ORCJBHEgbiU8EoiR8D0v+cFnCtIyh0FEIr6VLbBt5XaJGu0xPJlmy0gHTt0R7fiScBJ/r9WwVkkrcJ1IOvEDn8AX+PToC7/9ogV+gSzLtE1zRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504178; c=relaxed/simple;
	bh=BTDvtIT10/Y7dpj6Bwu/egzP7OKMQ3oLE5KC8jPsBrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iq0rsfvnFBLEmRW9efZgpTDX8cEGvEqRjwmU8P6LRALv75pFJHH6eBxEgiMaA69OVtoz4AgI97EQAda9mufyw3RNnUSi2lUj769R1J2rnBOAhv8jIF8EABfPd6N0b0ZrnXceg9jPXz/cdaTwg/vshwXgxwlvdGnBi9JXTZ38jKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmKpTFJZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755504175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BTDvtIT10/Y7dpj6Bwu/egzP7OKMQ3oLE5KC8jPsBrs=;
	b=UmKpTFJZgVRbvB3GOQlsq08+4K9d+F4jRERJSGY/NYDEaCgNfL7wOM7UFjK/DlER9AEyfj
	uru4qI3v9Jav8z/L6uOtqUk4M8HmHPwSxzpLxJevdWxBJiSFziND90+OLHZIdrT5L0zOW5
	MuHu8ReIm0troJRnP2K6LyQZAcmNSjE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-0MykIm82N2SQrLok2vl5xg-1; Mon, 18 Aug 2025 04:02:53 -0400
X-MC-Unique: 0MykIm82N2SQrLok2vl5xg-1
X-Mimecast-MFC-AGG-ID: 0MykIm82N2SQrLok2vl5xg_1755504173
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88ddec70so39213646d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755504173; x=1756108973;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTDvtIT10/Y7dpj6Bwu/egzP7OKMQ3oLE5KC8jPsBrs=;
        b=IZc0UwBTJ3aQsmcl121srvrZHo96pHNF/34SBxDrz+zEFf/cmZKi/QRdusJ5K2ftwP
         tB4gpgcyHckeoOIo42tYU0K/OfcceBZye06aybRDBnCUC2fzAk/Yeyk08sLqJRJi2guh
         BsDH1bW24LKtiaE38jkVcJCo1pIWwKN153MCMq8biqj8SujqxVuHsNmydIMSTIjODZJd
         /Uyi94CFM5v6CseUO+Aft4VbGvqTkXYIMEocGSC5RMTxmvs8KIIufr61vyj4G+2SUoy5
         sWf0Uq0+KGg+y3G7Er7rEtjt0P91ts6d2qCoHib4BhPcxYSVNwL0LFBBeQV38Wim0+uL
         COrA==
X-Forwarded-Encrypted: i=1; AJvYcCUA71oHbLK8Pba2y/90ZiMktRQtSWsJjy2c710fG1N9JjCSuR6B96opTvOULGzxdaMFmDv1qL+nQ+P68Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB1J3gw49LXBhVJsEe39lFv2n4QpB11ZGhCmzHOFtrepxi0cvc
	0lL+fVq29+xMhFPOMXHUf/XYL4JkPjX4XA2pO5CfIA8YDst02uLuVCli9NuIp7aBzQ+KHUT20YX
	t6qBen9iHN0dnR9Ircl9zMfgUlFfiP5bjPSxKLsPrdsw+sVMNsFyIIzQ49fkwgsIxsA==
X-Gm-Gg: ASbGnctMzn6xg/86aJqq6a3PtM621wh+eVKUVb/AnRiXplK+np2nPWSaNXJ8aE9RGrX
	+DLF4d10tnvCc+BufOw+LmtLDRwkg57nR7DEVKGv+aQ+gSazR9nk4Pd3M7AXe8uHWmw6fUSrct6
	zzqnXGNuUrxmtI2qduskdRzWrgkiOG0pfg1WuQ2Om84b1d1eF6+/fegkbcLHqcFmM3ZkaKUk/QH
	bIb9pEKsXMVrmfjWwTI7x5kGU9vZjqJ9XZdtb9ArJFbew92nNzj1wnPz50N+u1ueoFmf5ONWVTh
	1vZsFBpCrrJXs+pTB03Izfy+M6oC4tumpuTb7GY2hhuWPwzkpuD2BkuMr3Re3nd0Qw==
X-Received: by 2002:a05:6214:21e2:b0:707:5e7e:20f with SMTP id 6a1803df08f44-70ba7a8e0c9mr127652456d6.5.1755504173095;
        Mon, 18 Aug 2025 01:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHbS9oN+bmVLXNWkCtLoe4KkJAUB/SBpAzOahmwwKpbcS5hEqU1zFKZK8VNdKmOFa0tdBVBA==
X-Received: by 2002:a05:6214:21e2:b0:707:5e7e:20f with SMTP id 6a1803df08f44-70ba7a8e0c9mr127652076d6.5.1755504172501;
        Mon, 18 Aug 2025 01:02:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba959f401sm48756146d6.69.2025.08.18.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:02:52 -0700 (PDT)
Message-ID: <93e01a77105007dff602ab9a2a9af5b4cff86522.camel@redhat.com>
Subject: Re: [PATCH] Documentation/rv: Fix minor typo in monitor_synthesis
 page
From: Gabriele Monaco <gmonaco@redhat.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Date: Mon, 18 Aug 2025 10:02:49 +0200
In-Reply-To: <20250810111249.93181-1-krishnagopi487@gmail.com>
References: <20250810111249.93181-1-krishnagopi487@gmail.com>
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

On Sun, 2025-08-10 at 16:42 +0530, Gopi Krishna Menon wrote:
> Specifically, fix spelling of "practice"
>=20
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>

Thanks for finding this!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0Documentation/trace/rv/monitor_synthesis.rst | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/trace/rv/monitor_synthesis.rst
> b/Documentation/trace/rv/monitor_synthesis.rst
> index ac808a7554f5..3a7d7b2f6cb6 100644
> --- a/Documentation/trace/rv/monitor_synthesis.rst
> +++ b/Documentation/trace/rv/monitor_synthesis.rst
> @@ -181,7 +181,7 @@ which is the list of atomic propositions present
> in the LTL specification
> =C2=A0functions interacting with the Buchi automaton.
> =C2=A0
> =C2=A0While generating code, `rvgen` cannot understand the meaning of the
> atomic
> -propositions. Thus, that task is left for manual work. The
> recommended pratice
> +propositions. Thus, that task is left for manual work. The
> recommended practice
> =C2=A0is adding tracepoints to places where the atomic propositions
> change; and in the
> =C2=A0tracepoints' handlers: the Buchi automaton is executed using::
> =C2=A0


