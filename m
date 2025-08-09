Return-Path: <linux-kernel+bounces-761239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE72B1F5FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 21:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58403A9BD8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C91429CB24;
	Sat,  9 Aug 2025 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="oVH/H+CV"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431B2777E3
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754767320; cv=none; b=BYvkriXe78IEsjMZOd6QTb9hn2wrl8f28kLPRHebNczqsXJ3K3DPZUszxxefOaFtSIU1edKh3+tTBj0lwY1Adg+l91rkq1i5hkVA7GBN9nzZg9jrXjgY3KqE2goZ6KtEhgMOUlpeDaCcuGi7TSMJQweetsz6s4fhAwP0ojSIZ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754767320; c=relaxed/simple;
	bh=h3Apy+if9b+XE+PfNGkz/zZ+g5R4G5lXdu3AvwX0+OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvVMvjIUCbjr4inW94WW+ht0qb+zHiceVQ/d7JdyA2o0w6gGYsGPsOtclINTS5tR0Sf+W1LeE0oQSngu478zyv6totID4lF4v7CuuI2LYUEB8qDEMs6usrVfuViksESbLFvK9iclVMNkJAMLCOZuS9UCvYWK3Z3a9tdeb0esc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=oVH/H+CV; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e9066f408efso204329276.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1754767318; x=1755372118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNI3FzGuqhvpLMUoYQfTha9JCC3Gjeyc60VySTiyNyA=;
        b=oVH/H+CVTP2kIoCtmxAjtuWN4HZ7jsoeSpaohP0Nzg1zwyL8nj80w9wiUpEQauN1Xr
         ncwM+ufHVn4SFWVHkRwhfWqaA+LWqohoIcC2kjcb+7UZBCSJ/0d3XbSieafCjvzGsV7C
         k04JdjPqYFu0+mHaeg/hw2V4T0lKQioIpDm5ZMrWfQEM+RRKC0pGGvAnU4BBaSkQ9F0/
         EwpTonZocP6iPzhPHDNBVpQWAB9cexlUZOQCY+AnnRdzejL5thYskk6kHgt9Ld1pHV7Z
         jZERKc9FXo4YBkrqKfhYZsY6phAb+09r2i45Qbmoyu4lc2+VKXSW9kjh1P/XGhRb78xg
         nf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754767318; x=1755372118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNI3FzGuqhvpLMUoYQfTha9JCC3Gjeyc60VySTiyNyA=;
        b=EfLUbhd6w2wg8JMViMv0kgPJ2zUN8PGkPoM6J8voaxZ5UsMjgaj/DztB3F1SHIKHAt
         Z6kKBySV3iNHnIy4T+lRo+oP9LIwk+aG9f7vq7w9JR2JEecmOCg/jEjIS83tASk+JyVf
         mQGSREu53IXdXJoBLRMqH1uMfOhGyr/cjFrOqQ1KylW9em38/ahez2U9aACB2ZSEpGw3
         7ynYb/T6mmPxjqut46e60w+26OYQKDDyfcFyfh8b7dDpOv2B4EMdiSjL/LepNjLi0cPJ
         XSE4dgsr9MiP2Yv+C9yH4AEhj1/DYXkOJAirKrqLCtbbhwWjYWD6/+uNHtV3raZCJSDM
         11QA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+orjni1XxydUPclGJ5wsVGUPknN8XhrgA8UJ691E8YEJFWOIwaPlrDZrPW0PXYWjh5CTfX7357MqhSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qexFdmzOpjU8Uz35ailMScHNM8AxOzeCSmsVEI2SpNzmSHaU
	nErnH9uQFeJsj6lyrstEX00HXCBTkjqWyc7dPxk0iktGg5gEs/wJm3SRkfvWVDvOqmI=
X-Gm-Gg: ASbGncvBKX1DillpPbfmtjl9QvFs10iG19X1qDq2SMhy9sFGmHnmxxK1UF3Go5mNKro
	LRmyrqJqKNeqoQyQFEt0b8Oe11/0IVvgF1ZXoHE6unNt+LQRCJXjiA3fA5O5IfTswVPsEydABYJ
	qRhxxlkY/2gYUncsVgBppswlu1fbutwD99rgJUJn38mTEfT+UcF0+zezd6cE9VlHwfcWGFXiRhn
	s18eTRwygR/tB/Xc/QuWWW4CPf8urb8lh+35OtBljzruVLkWqpzgbue3uWySak8H05PYOZuaWlr
	zCFHBzs9oR4owqiDoI3qCeATyG0BpmQPwf6eCqdyTnH1t3FT9iPC1ixDFpyGb5yX8r2eUuABMP/
	5dfbYrc2I5grseMcFd4bmrWSb+LV1I9dUDgImGsL3OYm6iZaQuJnctYpNTDJgFHbqN7pStA==
X-Google-Smtp-Source: AGHT+IExmujknx2TM2tLuZiauHbhXnPmw1RB7ZvhZsQHYkPr1rGepKt+DAqu5eteErMK86fJg6JejQ==
X-Received: by 2002:a05:6902:4a02:b0:e8b:4282:65d7 with SMTP id 3f1490d57ef6-e904b579e55mr7609585276.25.1754767317816;
        Sat, 09 Aug 2025 12:21:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3860a91sm8336114276.23.2025.08.09.12.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 12:21:57 -0700 (PDT)
Date: Sat, 9 Aug 2025 15:21:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Aquinas Admin <admin@aquinas.su>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <20250809192156.GA1411279@fedora>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>

On Sat, Aug 09, 2025 at 01:36:39PM -0400, Kent Overstreet wrote:
> On Thu, Aug 07, 2025 at 07:42:38PM +0700, Aquinas Admin wrote:
> > Generally, this drama is more like a kindergarten. I honestly don't understand 
> > why there's such a reaction. It's a management issue, solely a management 
> > issue. The fact is that there are plenty of administrative possibilities to 
> > resolve this situation.
> 
> Yes, this is accurate. I've been getting entirely too many emails from
> Linus about how pissed off everyone is, completely absent of details -
> or anything engineering related, for that matter. Lots of "you need to
> work with us better" - i.e. bend to demands - without being willing to
> put forth an argument that stands to scrutiny.
> 
> This isn't high school, and it's not a popularity contest. This is
> engineering, and it's about engineering standards.
> 

Exactly. Which is why the Meta infrastructure is built completely on btrfs and
its features. We have saved billions of dollars in infrastructure costs with the
features and robustness of btrfs.

Btrfs doesn't need me or anybody else wandering around screaming about how
everybody else sucks to gain users. The proof is in the pudding. If you read
anything that I've wrote in my commentary about other file systems you will find
nothing but praise and respect, because this is hard and we all make our
tradeoffs.

That courtesy has been extended to you in the past, and still extends to your
file system. Because I don't need to tear you down or your work down to make
myself feel good. And because I truly beleive you've done some great things with
bcachefs, things I wish we had had the foresight to do with btrfs.

I'm yet again having to respond to this silly childishness because people on the
outside do not have the context or historical knowledge to understand that they
should ignore every word that comes out of your mouth. If there are articles
written about these claims I want to make sure that they are not unchallenged
and thus viewed as if they are true or valid.

Emails like this are why nobody wants to work with you. Emails like this are why
I've been on literally dozens of email threads, side conversations, chat
threads, and in person discussions about what to do when we have exceedingly
toxic developers in our community.

Emails like this are exactly why we have to have a code of conduct.

Emails like this are why a majority of the community filters your emails to
/dev/null.

You alone with your toxic behavior have wasted a fair amount of mine and other
peoples time trying to figure out how do we exist in our place of work with
somebody who is bent on tearing down the community and the people who work in
it.

I have defended you in the past, I was hoping that the support, guidance, and
grace you've been afforded by so many people in this community would have
resulted in your behavior changing. I'm very sorry I was wrong, and I'm very
sorry if my support in anyway enabled the decision to merge your filesystem.

Because your behavior is unacceptable. This email is unacceptable. Everything
about your presence in this community has been a disruption and has ended up
with all of our jobs being harder.

You are not some paraih. You are not some victim. You are not some misunderstood
genius. Your behavior makes this community a worse place to work in. If you are
removed from this community it will soley be because you lack the ability to
learn and to grow as a person and take responsibility for your behavior.

If you are allowed to continue to be in this community that will be a travesty.

Thanks,

Josef

