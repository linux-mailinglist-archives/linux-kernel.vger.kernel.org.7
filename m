Return-Path: <linux-kernel+bounces-791858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1959B3BCE1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64647170E60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1342E2EA170;
	Fri, 29 Aug 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1pJ2Mfy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0182E3360
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475629; cv=none; b=fsZ6Kqob8cIRc4tGeuPH55nfkLXzhJlDh8KI0xToR+v1f1wwmLuGLruwgviB2ekw+vR9XTJYZyJzU+Ez9DhloR6ajyWf4yWYFarUVYoG5+p3OGScqbMclS33A7w44BhAn0iTKiBtGzFTPB2/lqNDWaRPW8w8+4iv7g4xjbNTNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475629; c=relaxed/simple;
	bh=kAMW7dNnaq0OCstKrPcJqnF8T5RqOsJGJg2eHdFJdfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgfWCgnyWjpSIUZHJMkOrMyDLQRFd0VcF1wdEJMXE3MXsuhce21ANryjSb09e2Q/9SNpIaeVKOav78GKBRCAU349e54yeR4YeUU0h78volm6zxgvAFo84v16wWqSezmcfYhdzdOxQRK1fLfdLFVN6fBRa3H/mPaHczlhBMghzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1pJ2Mfy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756475627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAMW7dNnaq0OCstKrPcJqnF8T5RqOsJGJg2eHdFJdfc=;
	b=G1pJ2MfymrLMfdoeQruowk61aWmC8HHhJoxFIiUtLVeEcVGCID1TOz4f69CtmBEK9m1YOE
	lakGYd+qPOtudySc5tSm6sSo/UIq147smy2i9pFdSag7RestWG9qcqrr577M6Ou+yYcn5M
	5dLeU51tEw5+xhRzHAv0TCIFKgDCbgo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-SDrnZQQwN5OhSr2DhRgxxA-1; Fri, 29 Aug 2025 09:53:44 -0400
X-MC-Unique: SDrnZQQwN5OhSr2DhRgxxA-1
X-Mimecast-MFC-AGG-ID: SDrnZQQwN5OhSr2DhRgxxA_1756475623
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-336b13923d4so7098741fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756475623; x=1757080423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAMW7dNnaq0OCstKrPcJqnF8T5RqOsJGJg2eHdFJdfc=;
        b=QJow9hBMj8RvQBuJUTlAOR8+tGB+GjWrQ1+Zs0DPJANwc9rZRIn76M0LLlOLFGhj+v
         veIwlzBROik9fP93ys7H7ubfAGsYXVfQsaSlQ34ML/q8dHKECvr+bUn1DzWHlJTBNIPY
         nn9M2FYDJ9Bc3u6rhZmF1hhQQFa8yWq4HqW3XHfKgt9woE3P0yyPEXC0MGtiyfXOyK2q
         3KMrStSZycKGWGc9BDasPMKlfnh9JddvMDhNJvZ0iwNKABhyB/geNvpKJRm3vMva/gOF
         pCVhai7gdixkhicMjbWt/HDt0trRijjcwPpCe1nQcwaAzOOYRlPRFh9hXVLrLLaYrFZA
         5BSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMfqfypvCPBn4YkRfGbw+NVA62iN/RvQ64ELBeUER0v+GpD6ToRWx7V0eDbyanSlLaxDi6nzSb7KXTVSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAQMOhR3nwkjPbNf8mqMBrqZmJSY/crSax0ahILg1jk8u7DvC
	6qmevWiKJ6ye8pKwzaj1RaKE8KKmxHe4mlfsUB6Ca26fNDDaNbUuctDfYnojzKQky9a0hHJosKY
	rfBwf31dzJRVrb1m7dSOvl0pZE+0EEJVUUq8/E+37cpHs8PzVUF6WqBRHuJXHGvQLPlRW55fO17
	msCd8AmFDYjDi3oe3gPYjuE4g+u3QhyTr1oi0zR3gc
X-Gm-Gg: ASbGnctI5SnE6fu8hiUVPzZeK4vGhu2HCvkj0zYoWuki35UlCPfxdlzQGhgIPDNL/AO
	3neQfY0fb2AFuLSXwfWKG6QMkCKqOLjmPi2v4MxI78/R3jjlQ9Wy1C6T900qytH35y3UHGpKoXj
	SgGOLIsTYak+o7nqjrQJDMVvxZAcRLFpzrf2YYgEJM1p8RnyLkgUV0iXY=
X-Received: by 2002:a05:651c:1a0c:b0:336:a38e:486b with SMTP id 38308e7fff4ca-336a38e4e6fmr19340091fa.37.1756475623155;
        Fri, 29 Aug 2025 06:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG3EFw17S3IWQD0fjsoX++MGPxq6vbq+IqfmVOosc8Y2GEhrGtIUTfmeh6bjQcMk5h81vgu0ji4w9Vo0JiGeI=
X-Received: by 2002:a05:651c:1a0c:b0:336:a38e:486b with SMTP id
 38308e7fff4ca-336a38e4e6fmr19339981fa.37.1756475622757; Fri, 29 Aug 2025
 06:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
In-Reply-To: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 29 Aug 2025 09:53:30 -0400
X-Gm-Features: Ac12FXxJEwvfKiYu3k-PtLRK81E2-L6NLWxERX13IrmH1QdrSFSv6JEQyIa8v4M
Message-ID: <CAK-6q+js0y9Pnubg0ev3_GXs8Fa4KYU=nNP5r=FBatuEAUhJkw@mail.gmail.com>
Subject: Re: [PATCH] fix(dlm): handle unlock/cancel during deferred lock messages
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

What is this patch supposed to do?

Your subject states something as a fix for unlock/cancel operation.
What is the problem you encountered there?

- Alex


