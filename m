Return-Path: <linux-kernel+bounces-840165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC79BB3B95
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2695316E6E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B843081B7;
	Thu,  2 Oct 2025 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcWtkepg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF525BEF1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403834; cv=none; b=K7o3aHKh+l19jN5fYI6GhYnYhWSD6a91p7gYx1b2O/VmVnHDMLY4aexj74CSaltaxbfiiBhzqYoLrCLr83ZJwnWp/Kk8MyGnQX4Wp9/+kwaTANjd2mdDf6U6/iYdXMg2/+fL3SsDX06CSkM+r5bv7uFbGTXZSY1CZ3W22uXhDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403834; c=relaxed/simple;
	bh=Q77oJzKKU3yE1nwn1ezBB6bK11QxjZntnGjkk9VN77o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grouH1pL5Nj8T4c0Uktsq8xa99ZnNlVYF5IGMr72fp3AyQPrnZSEAeKWGFK0CSNM/p32cH2PFdwI4W8BzpE5iB4GJn7pKC37/xiOdTwlQZO+CCS39abQuO+HMZHkQBNpIGDhE5Nrx79RRi17MB5qVI7IpCsw2pUaT4jqzimGHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcWtkepg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759403831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q77oJzKKU3yE1nwn1ezBB6bK11QxjZntnGjkk9VN77o=;
	b=QcWtkepgq7n4vj//tJy3Bihm1q3XsYiLQ1+mKtUMgSnyTpRNVJQPF/HYOc5UOokWJh3PzO
	81lRaQk8WjScehSlse+dwO/bNaPQy/fokHcNtzSzHqE3A4/Jw3e8suNckKG0mqn5yT4Lcu
	HdPQcCyNE0rgJhEmSamcpZ8WvMInLes=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-UdkCvpG9PbGnLgmBNZXcXg-1; Thu, 02 Oct 2025 07:17:10 -0400
X-MC-Unique: UdkCvpG9PbGnLgmBNZXcXg-1
X-Mimecast-MFC-AGG-ID: UdkCvpG9PbGnLgmBNZXcXg_1759403829
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e407c600eso4668395e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759403829; x=1760008629;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q77oJzKKU3yE1nwn1ezBB6bK11QxjZntnGjkk9VN77o=;
        b=ib2ooGEAsrbhTUD6+6VjoQ5wj2T0OeFwvg4d1PIN/38woLs3kY5g26LVo6qnnmDYE8
         UTNFk1SDpiM4aLgrjswhbmzqjq37edrZwOPqFwbsssHnMJBo3x0llVWEtiMPjJ/XxOEZ
         CH/fMK2NQp3weKAUGGjjZk5z55t0DZ6S2zCwMrF3uaYIf/jd21V9/b8VSuT+JRadMS9f
         DEUt/NMFQz6o9C67mX9D7ZbgKHGfEjhyyiITGvrYWEh4fCnpRrfc5azROT8x4qPic1LK
         nYLo/JoARxveKTGxbzDWZY7d5Eek1dC324yZIqJc2tlKFO7D10IKrfMIfN+IiypMW4Cy
         LMLg==
X-Forwarded-Encrypted: i=1; AJvYcCXMr0w6KNTQwnoxu5S1NGNX9NkfhiE9TeggN/1ZG9f7HZT1e25qrCJkG9N4FMmZG5juIgADdD0fsJrJeFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjevzdhmeytlkFdmaSPqrXQqnxep7xKYpSW6crc046OWr3xKru
	yiIaJCrE/QKldvtTtq0PwVVfsGSJX7VH0jNX/PEa86Qm6d+AXqSJc8ogd+0ohxpEw73Kenrmprk
	Ywg+yUelpkDEJA4cW7zxZs+HVQE8kG/XPpPlUelh+OXMRRjliipfONQoSUcO27e0TDQ==
X-Gm-Gg: ASbGnctbBItpMeuB9ImM8DbT7elZl0z4LfqUSa9GzQGH2Itg0EFU16sMg1UYoW8N2+n
	cw4FWA54muAqDcAnUVkiawoCD7LhErRiUghoRfYhv46TcGgMc8KokjVLXGFh7v7W8iAF1mIjc87
	EZyjixnuqXUIfSFK8WCNiG13zmZAZqAfr8LGjzzQ4znfW2sz7Zwi+JC7EFDML40AEd5BMx4YFrj
	O1ZcU9sRtcw5eiTk2JZV2LqfqH9cv1IvtjAa/OxFF18NhYRU2ZvkDREIWzF2Ogft7nARjd+NkQM
	VX/CDgGyOQuzkBw+RtL4qwCeCfutiQOR46KBSPCxKHuG838LuftF4HxZcmxUpeSaXmnm06Y=
X-Received: by 2002:a05:600c:1f86:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e612bef22mr49128165e9.18.1759403829218;
        Thu, 02 Oct 2025 04:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb8dml5vciNP6tQjqRhGREi9kZK4uoaYdLf160JpRfikuws22jqCWavi5Dapn7jZSLafssRQ==
X-Received: by 2002:a05:600c:1f86:b0:45f:28d2:bd38 with SMTP id 5b1f17b1804b1-46e612bef22mr49127955e9.18.1759403828766;
        Thu, 02 Oct 2025 04:17:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e637f7c00sm67120645e9.22.2025.10.02.04.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:17:08 -0700 (PDT)
Message-ID: <b2eccf79b5ab2b0d4b2f02e048938e923aa6e619.camel@redhat.com>
Subject: Re: [PATCH v2 11/20] verification/rvgen: Allow spaces in and events
 strings
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Thu, 02 Oct 2025 13:17:06 +0200
In-Reply-To: <87v7kxr2fr.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-12-gmonaco@redhat.com> <87v7kxr2fr.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 13:03 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>=20
> > Currently the automata parser assumes event strings don't have any
> > space, this stands true for event names, but can be a wrong assumption
> > if we want to store other information in the event strings (e.g.
> > constraints for hybrid automata).
> >=20
> > Adapt the parser logic to allow spaces in the event strings.
>=20
> I probably misunderstand something, but isn't the description
> misleading? After reading this description, I expect the patch to ignore
> spaces or something similar. But from my understanding, the script only
> allowed a single event, and this patch allows conditions as well.

The script allows multiple events, all separated by \n, strictly speaking t=
here
is nothing saying spaces are not allowed in event names, but the parser bre=
aks
if there's any space.

This patch allows spaces in event names, conditions (separated by a ; ) are=
 not
supported yet.

> Shouldn't this be squashed to the next patch?

I kept it separated to avoid pushing too many changes in the next one, whic=
h
mostly adds new functionality (and lines) instead of changing the current o=
nes.

Apparently that didn't make it any clearer, and there isn't really any use =
case
needing event names with spaces, so if it looks cleaner to you I can just s=
quash
it.

Thanks,
Gabriele


