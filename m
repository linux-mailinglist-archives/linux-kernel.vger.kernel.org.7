Return-Path: <linux-kernel+bounces-824644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2551AB89C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A091C87DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10951313273;
	Fri, 19 Sep 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQZOnGXB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150C3128DA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290367; cv=none; b=Kh3BZQ/72SToKmox2sZq/RPfXgA0kLQP7nlUpMpI3jDfhxuHC573a+crofUBsAoNxI06vJ71nyZc1v7DraHQ1+2iIsfJjH9ESTjkIPSOPcltzte1lC3L+UnZAHudkYtTCuZPcYcYWrGGxHiyT4HBYp2W31AkWLoZAcHBV//jgvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290367; c=relaxed/simple;
	bh=E0aKd79dQRldmcXYoHZeP6fkSHuLvXaXqPGKYoA27iA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ze58fk3/Y9l65iOmEVHDe28t8UV335czBY/m6XxssOf3nhmtOVJ+5XRJgGCrPoP6+k9DrU9Ob9qFPdznR9tITC/Gb4xnvifRei0j13aOK5+bxH3X8okyEg18eHizOvS6UUp1wcq4TGdT+7VK3rdj1gN/S2SurGTMQatR3F0ZvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQZOnGXB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758290364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0aKd79dQRldmcXYoHZeP6fkSHuLvXaXqPGKYoA27iA=;
	b=aQZOnGXBmeMP2e1zhIvozuzyg1lFQJfGDW+npIh4M0E463iOKNOtjqzr40uXzdp6njgzTW
	1Mi/trpq8IAjVqpu76RRabzDwmDTjgSK4hi23yfU+NbADAcMEaR/J9qZDD4sbMbD21DfqF
	zeYKxoDm4YEKcN9DJUIjItdGqIQwGas=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-2_HxXcHiN3uH7SmR6yMjFA-1; Fri, 19 Sep 2025 09:59:23 -0400
X-MC-Unique: 2_HxXcHiN3uH7SmR6yMjFA-1
X-Mimecast-MFC-AGG-ID: 2_HxXcHiN3uH7SmR6yMjFA_1758290363
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5e9b60ce6so61602601cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758290363; x=1758895163;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0aKd79dQRldmcXYoHZeP6fkSHuLvXaXqPGKYoA27iA=;
        b=GmsVfOdLMFkhbR/MgzUmqWcmL4ukRw4PM5g9pp5FYK0SuJkyApPxHdypKicwut8zCT
         TV9ck2xirSrKznkFD/E1tIXY6c5vQyzsvoAkSgX3E0fdKAfDntaJ3JcZVrAb/LOOemks
         6HtNWlaEqLRnwlxQbMCvYCqZJe8nblprA2bxIvidsfTp/gGG9dmxZwjIk1yYoFDb+l7H
         5ymh9HMW6fKxiz9y1+AZarbTnc4VOSLqPDOHvRCsXIX1nkCbl4ysGZV0zNMOfsAkLoQW
         Y0ANNsmnxE9pY829B/Fx1/SsUYdbStCojJ5E9nZ+cZ1+1vOGyPwnoruZpZAdVVX0xI4Q
         Q16A==
X-Forwarded-Encrypted: i=1; AJvYcCVWIS62BvIv/Hu3qmz4VHqOXOhufE+AkkD7+8pnWObAkrWMa27T7Wv7Ux3PfAnSXxY1MZjSqf091LDocWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGoPII2/YM7xk18utDqBPAPi1BEncRjlfOeHE1u6mbSDQp2l+
	dqU3jbdLMSiqmuXAkHtyzOlggUZOfTOyD0npUHRNFUF4xsD+p56sfOcxmAM78zvPKKU0iMUYXsn
	JgEO3NTHLfc4Pz3V0eztGqX+SE3MlBj3VO+wkvvP/XOexHmnohnxcn+pQYQFA4VMeMQ==
X-Gm-Gg: ASbGncs/n0BUrweZCKDi+U69WfsPh53ygUKpGGU3Z93iY5BlB+XJX1k/k5/IHXFykGh
	c7UOgXJg5d2Rt3ITc507XO/YKn17azLOGzfUUmjnZZAhjugIzazQ95jlW0/buVmWBefOHrkuTKw
	xY9jKuEbFzu3ZzmwlCDgqnbwj03EMmVdO05+xZ+uHxebB1fiddmlyeabUzGEVcA652QtdfYUmxC
	g9nDPFLNu4kbk5AmUtskoS0QxPgldlCqdjiUVCpBrKT5RgJv1k6SGdqJEXdH0F6gou3iXDh+Wj4
	MYfbQvFwWvFY/9j27WzQc0cHqJoxoFRilg==
X-Received: by 2002:ac8:5dce:0:b0:4b5:f59b:2e7 with SMTP id d75a77b69052e-4c06cdd8d53mr40676381cf.9.1758290363017;
        Fri, 19 Sep 2025 06:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZORXfI+7Pv8Nbr9EEpWupK3RCB0YdG+gi72RSlWrDN1wMdtZXcENcez+iU5vJ3qPlyNBw7g==
X-Received: by 2002:ac8:5dce:0:b0:4b5:f59b:2e7 with SMTP id d75a77b69052e-4c06cdd8d53mr40676021cf.9.1758290362591;
        Fri, 19 Sep 2025 06:59:22 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::318])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bdaa0c5156sm29082401cf.45.2025.09.19.06.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 06:59:22 -0700 (PDT)
Message-ID: <2df4e63a5c34354ebeb6603f81a662380517fbc4.camel@redhat.com>
Subject: Re: [PATCH] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384, SHA-512,
 SHAKE128, SHAKE256
From: Simo Sorce <simo@redhat.com>
To: David Howells <dhowells@redhat.com>, Stephan =?ISO-8859-1?Q?M=FCller?=
	 <smueller@chronox.de>
Cc: Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>,  Ard Biesheuvel	 <ardb@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, 	linux-crypto@vger.kernel.org,
 keyrings@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 09:59:21 -0400
In-Reply-To: <3788819.1758262666@warthog.procyon.org.uk>
References: <2952535.lGaqSPkdTl@graviton.chronox.de>
	 <3605112.1758233248@warthog.procyon.org.uk>
	 <3788819.1758262666@warthog.procyon.org.uk>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-19 at 07:17 +0100, David Howells wrote:
> Stephan M=C3=BCller <smueller@chronox.de> wrote:
>=20
> > For a multi-stage squeeze, it is perhaps not helpful to zeroize the con=
text=20
> > here.
>=20
> Yeah - I've seen this now that I'm starting to trawl through your dilithi=
um
> code, so it will need adjusting.


I strongly suggest creating a test vector where multiple absorb and
squeeze operations are done in intermixed order, and then use that test
vector in your Kunit tests to ensure changes to the code do not break
this fundamental property of the keccak sponge algorithm.

Simo.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc


