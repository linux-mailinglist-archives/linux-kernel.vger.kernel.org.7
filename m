Return-Path: <linux-kernel+bounces-886621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738EEC361E1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CFC43B3A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3A32E74A;
	Wed,  5 Nov 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCICHe/S"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F82329E62
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353506; cv=none; b=WCGj1paepEgePRYNTXT+oYW8OlTE0dRUKo9NtI0PHUPqBwC7tF5GrRm2i8VRMCvV1/qh2hkLi5HdSVNnpGrGC2oJ59jXcmLexSTkhsx6ftLAGUtLgBxVDMeURltWV3wDIwPI5voVJhQTN/Em3v2p+lUIvm3pKmu1N5D6qqntQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353506; c=relaxed/simple;
	bh=YwmIrc9rncm8jYwO6rWq5RbLiYWZvoFNa6HUs4etLrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlI39dd3prXUKGEoae26fzA+kFx7WXdX9w79Gk2JJLrUK8Kv+X1TUlSyTURaNy1wB2lZcmhtW42OcuUcyDyaolLznAFQ0Ch2sU757G5b6iTA1jD1YpKCHgPl4IGgFVWVsTxNIz3XOcbRQwKNwfRODziahbiVlqCh3NWHU9SMWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCICHe/S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47755de027eso14992225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353503; x=1762958303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LkaRIn/NSiNJWnW7QBCmH2dkiWqmxXew9zG5Ks3bGA=;
        b=TCICHe/SRUFQeH3T2Y4BBy7jUFSkwnQkzEPadBCAFcYJEGohyxhmYwSzcZwycAuV16
         uce1XOg8+Id93v50iLyPF/yvG8fALVI6sPdik0ub2MtnZZPoEfFDct/XthB+u1qL8Adq
         hdE0l+7eT28mXolkFWCZ2jsJyS0TVSch5fB4Q4ozVbIS/bAJTRfaKkjd/UzLdtFBt5me
         IPxvxFND5gkimaZcD0q2/EJwIak7r6YBLRXdG+BkKhFh98ZbbFA1wEaOxV98UuBCvFFs
         IeiuissUmUdt8wT5B2hLO1rRkjBgcum0OFQ2eY2pYAXI3Q5GDou4oIwRMJUdyNuttAm+
         D+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353503; x=1762958303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LkaRIn/NSiNJWnW7QBCmH2dkiWqmxXew9zG5Ks3bGA=;
        b=gbcRg62bSzzDEajHYcq/95creZmZbVRUQZG7gTT1y48Xr2I8rbUHeG1mkbyfwDYwFu
         jKzTWfoqW0mGAmFthiJ0PAm0vqRJYKsMUrnJ+odHpHA2UlN3Gmvx7JfrxdDp/Z32cCQR
         nDeAqWfgYyw0NlcJ6qNxj9BKlnMSACKYWQhZh3Yo2MZYwn9TfZA2icOEZj8VxCnn0HAa
         2i47syhXLqbT+mkrNEavATgh/6pyQf+EvSnwHpsoVSXsjBDJH6Twcp+DeeYkddr3eBl7
         6x0hgmCpNQ5t9ekhitJyyumHWpaKYiKSiXBZhnZATDW6mELCXHk1Ee6XxXxfznVLxPZP
         gjaA==
X-Forwarded-Encrypted: i=1; AJvYcCXCfNtmyY5ktyVQXgyf5AZxFvHhfBPuIrWS2PUvWK2LPuteL1UzpMnupcUIO+L6Bris5QN8Pn4WRuYNZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fHTlI0XxNIwpakMehiKBBzYVT5Jov/sfc2m2FeLlnKjGgr6g
	U+Z+/eDhk7ik+ZyrdSR4VV+bfkC5G7yGoK0UjtumfOzoKvugU0yduPiD
X-Gm-Gg: ASbGncvjrDm/8cFXyftAPinwSe0E3ObS/Xd/QiO0yiP1APCgGK8+rn3yhKUgGcNQuQI
	9Gr41reJDBC+6pj/yXaZbxleO+3Y8h5eujdgRH3rQIzjetnfwTSEHaBNCv1+UPHCMKQJjdE2R1X
	lFteVKftoRmbiRrq5XEr/aknJFlfi3mHxIeUoULZcWy1S1EFvGNDnf0JLywZ2DtdPtzmh7OREUn
	lWb4ALuPzTFn4hMD0Az3zuFJSHXGcqmPdNFidO72qRER89Q6xpGJsAtmmNgyf5bjxEIJ7G+TpeM
	lgQds4kId4ZuDCaC1AOXHksumkRZCOsio7IN3KY+Z8DXwffEUdZzv4THdsOpaIQ68I51hqMVeBy
	sHCy1pPVU3ZSU+2qYFE+VuoFxsxU6f6fjl0zTklzBjtR/pqWZE7U6Iz4y/angFEJvSyXMSuXE7P
	bPoS2wlLtIVe+XipgAidR7Ufex4RY2SLYmZUjyFCQOkFUr5Hi625/E
X-Google-Smtp-Source: AGHT+IEHIwFXlJwm0yt3wS2IwhGgmlEW/3ZYotu2V04LIxWOLcO6w3z/6QAwxlyH+LxvfC1sir4Grw==
X-Received: by 2002:a05:600c:348f:b0:46e:2801:84aa with SMTP id 5b1f17b1804b1-4775cd3bec8mr38687765e9.0.1762353502780;
        Wed, 05 Nov 2025 06:38:22 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cde39f9sm54314335e9.14.2025.11.05.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:38:22 -0800 (PST)
Date: Wed, 5 Nov 2025 14:38:20 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Andrew Morton <akpm@linux-foundation.org>,
 ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
 idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, home7438072@gmail.com, linux-nvme@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <20251105143820.11558ca8@pumpkin>
In-Reply-To: <aQtbmWLqtFXvT8Bc@smile.fi.intel.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
	<20251104090326.2040fa75@pumpkin>
	<aQnMCVYFNpdsd-mm@smile.fi.intel.com>
	<20251105094827.10e67b2d@pumpkin>
	<aQtbmWLqtFXvT8Bc@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 16:13:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Nov 05, 2025 at 09:48:27AM +0000, David Laight wrote:
> > On Tue, 4 Nov 2025 11:48:57 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Tue, Nov 04, 2025 at 09:03:26AM +0000, David Laight wrote:  
> > > > On Mon, 3 Nov 2025 19:07:24 +0800
> > > > Kuan-Wei Chiu <visitorckw@gmail.com> wrote:    
> > > > > On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:    
> 
...
> > How about this one?  
> 
> Better than previous one(s) but quite cryptic to understand. Will need a
> comment explaining the logic behind, if we go this way.

My first version (of this version) had all three character ranges in the define:
so:
#define INIT_1(v, ch_62, ch_63) \
	[ v ] = (v) >= '0' && (v) <= '9' ? (v) - '0' \
		: (v) >= 'A' && (v) <= 'Z' ? (v) - 'A' + 10 \
		: (v) >= 'a' && (v) <= 'z' ? (v) - 'a' + 36 \
		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
Perhaps less cryptic - even if the .i line will be rather longer.
It could be replicated for all 256 bytes, but I think the range
initialisers are reasonable for the non-printable ranges.

I did wonder if the encode and decode lookup tables count be interleaved
and both initialisers generated from the same #define.
But I can't think of a way of generating 'x' and "X" from a #define parameter.
(I don't think "X"[0] is constant enough...)

	David

> 
> > #define INIT_1(v, ch_lo, ch_hi, off, ch_62, ch_63) \
> > 	[ v ] = ((v) >= ch_lo && (v) <= ch_hi) ? (v) - ch_lo + off \
> > 		: (v) == ch_62 ? 62 : (v) == ch_63 ? 63 : -1
> > #define INIT_2(v, ...) INIT_1(v, __VA_ARGS__), INIT_1((v) + 1, __VA_ARGS__)
> > #define INIT_4(v, ...) INIT_2(v, __VA_ARGS__), INIT_2((v) + 2, __VA_ARGS__)
> > #define INIT_8(v, ...) INIT_4(v, __VA_ARGS__), INIT_4((v) + 4, __VA_ARGS__)
> > #define INIT_16(v, ...) INIT_8(v, __VA_ARGS__), INIT_8((v) + 8, __VA_ARGS__)
> > #define INIT_32(v, ...) INIT_16(v, __VA_ARGS__), INIT_16((v) + 16, __VA_ARGS__)
> > 
> > #define BASE64_REV_INIT(ch_62, ch_63) { \
> > 	[ 0 ... 0x1f ] = -1, \
> > 	INIT_32(0x20, '0', '9', 0, ch_62, ch_63), \
> > 	INIT_32(0x40, 'A', 'Z', 10, ch_62, ch_63), \
> > 	INIT_32(0x60, 'a', 'z', 26, ch_62, ch_63), \
> > 	[ 0x80 ... 0xff ] = -1 }
> > 
> > which gets the pre-processor to do all the work.
> > ch_62 and ch_63 can be any printable characters.
> > 
> > Note that the #define names are all in a .c file - so don't need any
> > kind of namespace protection.  
> 
> > They can also all be #undef after the initialiser.  
> 
> Yes, that's too.
> 
> > > Moreover this table is basically a dup of the strings in the first array.
> > > Which already makes an unnecessary duplication.  
> > 
> > That is what the self tests are for.
> >   
> > > That's why I prefer to
> > > see a script (one source of data) to generate the header or something like
> > > this to have the tables and strings robust against typos.  
> > 
> > We have to differ on that one.
> > Especially in cases (like this) where generating that data is reasonably trivial.
> >   
> > > The above is simply an unreadable mess.  
> 


