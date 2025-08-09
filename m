Return-Path: <linux-kernel+bounces-760928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78028B1F216
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 06:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7247223DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 04:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01B274B42;
	Sat,  9 Aug 2025 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EDPaMow3"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D91374EA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754713981; cv=none; b=kkhu2VVJ1qm9z9Kf/zpPJXh5Gf8iE1JvOhaBTpCuBHXpH+1f/E+FZhW9Yg9YmzkTNCwINKd92ry/2rH+0N1zOCuPsNVR9+rN+BjJ6DiV+ltAY29B9o0YLPuxnfOsF407b/LaCIGP8XzTf/bYfP+oRKcQrbxQOsqoi+RlNWu1Kgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754713981; c=relaxed/simple;
	bh=3j2f3Q3qaDiwQ77M/AgMn60ASwYucXL52DAzl2u5P+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFQ1ncX5Wy4Do1O/Uz88RaNq0DXZ38dXFIFt4rhevm4/2vXr+s0E5crR1MXNCwVkVxflec3P2ZpIIasVHUs5OkbKkzvMrv/OpTyrVCM31xgXJ4qiQWBDU1eELKkqqI+SWUNMeXkeEtI8xJfuZU8qbGzod6qoKkmyowccyPJ6xHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EDPaMow3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6180ce2197cso247986a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 21:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754713978; x=1755318778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkD+P2y+y39hXD0Pcj8Lfy9t0SWSXpSEsHCRhG/IbnI=;
        b=EDPaMow3X+v9RQcxn/+Tj7QkOEeJWcLfMEtg81qEJu/vXwhwqqQAYURrZfMlaUY9fR
         39UMQ2qs0zSMxLIDiywMgoOLXI7oMQfty8NZ5JpG/uyEoBfDw6Ye5zUrLzQWXwfyp807
         V0ApGMQWokysshd0i/7XhM+mUbcxySslS2Ms4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754713978; x=1755318778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkD+P2y+y39hXD0Pcj8Lfy9t0SWSXpSEsHCRhG/IbnI=;
        b=TBZ9fh/hY/mbYQ+zwbWo6L/Bzn9PjU+mFL+YbWd7PBGas9Tmhp5pvQzkS0x+vNTZEp
         WUOkYgXUTuzyHlcXJVVmpWeHjrIVrdI7bHodLrAQ/RlGbb7fmipdDwTwP+vHi1ig/v2q
         iPL3Xr65A+QDB2LHubxw7ZswUg3duzskxh9DPSp4xaF37cwe3walnGHyOa3nNXNFpeFp
         hQ1cRmdLL5SH9CpN2eXK0s0BwIkm9ElrV+s4vIDBXHIj79gtVyeEMhv8RSdBBQ6F+gV/
         uH8w05L1PMLxluUSwkeyUJ35U4sx276KiBK5gm3pMFpNaoX4cXme9nkZSTpClVoO5QIY
         xpMg==
X-Forwarded-Encrypted: i=1; AJvYcCX139Cgg75ojkzGslHGwWHr1vik7m2zikET1ePC1r1eCspAr8aCt1taHveKRzKxU/PUVbZQi8MIXM1Zz6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXKcXK9nY1D3387u+7HgJ7+ghsH/4WYBcUG+n4GzmcL9/t6aM
	4pRKYWqXY5KCRhxy2t7a/TTw5isHr9l3Zh2DA4d/GZgxFhcySlqNZAUvjL7/AIvP+23d1BzJqir
	1Xc+HwSOv5w==
X-Gm-Gg: ASbGncuOusZHEQ4LquP4WJoTR0WLDlExxhNftEE+6jTbsmimjiVRgSIjQ+6bPdlQgyw
	FkBByl9VLzFegDh8lE2hr91EZX+4Wz1aHozrtIZP8SgeR/O9cxKEywovxlkdQnjdm7G5a5uhtfI
	CgBA4O2v5Qk4/9dcfO9R7dSlva+md1wZ6aVRbpgr5TzR/jYaKY95N2MnJRov2OMxKmJhlRgh3P+
	lJfq9zbTz40GtSefe4QecesazNFR7CNMqcVDpZRVZAJG1boI/1zsVO5ynIlV3nH1qf/lUZalXOD
	mdl+tp7QV4T49JVvU8/q4M5yfDGcrelfgqQnqjnzq2FmqAsLo2jrsrYaJ+ouTYii0MnVXETCk04
	mD612AbLqk87tLkuWIBZ62prf8PlW88FniH73HfSkw0SPpBwk81KukWeg6WfY6zadoW0e+W/3
X-Google-Smtp-Source: AGHT+IEZQyCPiD/avRenktkG4jTAKisGU88V/z3siOWi0D0JlUWR3XCjU6pVgmtiORj0HGb9n8iPmg==
X-Received: by 2002:a17:907:6e92:b0:ae3:b22c:2ee8 with SMTP id a640c23a62f3a-af9c655325cmr404636266b.37.1754713977633;
        Fri, 08 Aug 2025 21:32:57 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fb8bsm1579485866b.123.2025.08.08.21.32.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 21:32:56 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso482748666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 21:32:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa88FC3PM2z1PrxC7+bJRHQxZy6ZhbtFojJQw3yMh+lhu4x9FsW8uKNMRrHXWJOi2CGCWzyGuqB/hD05c=@vger.kernel.org
X-Received: by 2002:a17:907:948a:b0:af9:69d1:9c6d with SMTP id
 a640c23a62f3a-af9c65b02d8mr501213966b.40.1754713976386; Fri, 08 Aug 2025
 21:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJWOH9GgXhoJsHp6@gondor.apana.org.au>
In-Reply-To: <aJWOH9GgXhoJsHp6@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Aug 2025 07:32:39 +0300
X-Gmail-Original-Message-ID: <CAHk-=wgE=tX+Bv5y0nWwLKLjrmUTx4NrMs4Qx84Y78YpNqFGBA@mail.gmail.com>
X-Gm-Features: Ac12FXzvZx-Q2z8j9r1ZnqxMDu_VuBdhbV9giLfb4eCGbjAuOV9Pm09Va7WqOBU
Message-ID: <CAHk-=wgE=tX+Bv5y0nWwLKLjrmUTx4NrMs4Qx84Y78YpNqFGBA@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Fixes for 6.17
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Aug 2025 at 08:42, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> This push fixes a regression that breaks hmac(sha3-224-s390).

_Please_ describe the completely random strange constants, and why they changed.

What is "361", and why did 360 use to work but no longer does?

I've pulled this, because I'm sure it fixes a bug, but neither the
pull message nor the commit have acceptable explanations.

And honestly, the code should be fixed too. Having a random constant
like that with no explanation for the completely random value is not
ok.

             Linus

