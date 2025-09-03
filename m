Return-Path: <linux-kernel+bounces-798270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5EB41B82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A3A1684BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FB32857FC;
	Wed,  3 Sep 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2tlQAxc"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DA32F77A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894592; cv=none; b=EyrIIS/lyy3BHHy/7tEmllu1zG5sZoDLpHwpIQFzTVJRXitcKIxnEZNfa8NYZ1PR7EOqkQQDPhN38+AmLbe7FW0splK5FPNuCKC1izgUksjg6l1MSoHLNZEd3wQfjij0l17vZOo3YLKKpo44dGwTeX90Ay3+NdqALY8qmnagPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894592; c=relaxed/simple;
	bh=Vysyoass8/7fXChxkNXCAvtsZyl5TuEWzgR+DsRg3BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPpRDUkpzOg7fvF5acIlHGCIVZmk1gKWLeRDXCGb4vRwZotblx7J5F316RPoTiakjbKUjnRfm5hz5DLOBoR+/nHse9mdqj7Di2KU/jnkOyAh+nCNWW9THHNLyvEGu0/eaIcZaRzNuMZftziT0/1XOrbGJ6zq3uiWsFF+WpEaOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2tlQAxc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-726dec342bbso783806d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756894589; x=1757499389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vysyoass8/7fXChxkNXCAvtsZyl5TuEWzgR+DsRg3BA=;
        b=A2tlQAxcaqgPbfxuj0cjdT8ubz0gSevPDx3k+mhSkxb6cAtrK7Cf802ZOdEFayP8Lp
         LYAx7l/cXYzOcHl9GQCpU+Rm1MHXAsLhxOQGVymHuyf1WBa9WmqbsZQuIkA5W3pBJ7N1
         S8cWxIlturU2VVAgCEl9to4Omo8x1efhfdeMQHNExx2wpTQGJhu/r3Uc3RY7ko8nqmnt
         +yeuCq0LhRR/CYwlCqZCcnf7ktqtmoDP85OgozU4L2DWjc4qoGj0s4msJ0Ha6qOKp+II
         VwVS9wWm/swWdTFHxYCxKZg5fX+SCSSWBlfLyJEWBpxesRADvlACeFKW/u3dnMHvoliB
         zwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894589; x=1757499389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vysyoass8/7fXChxkNXCAvtsZyl5TuEWzgR+DsRg3BA=;
        b=QIG7lsjMWMhmss7Nw9rkKtLR6EdhsekyU/WlAlBncBFPgUQJuY7w56BljKnztO7x2W
         ltwLvb/jk2hDmcrW+dvSPpPQTbPbizE18/b6RqWzfKPrN/kEfgge6cOD+xy15bX8EK0+
         mUWzplpMO+mzguJjJLwwzCceMMawACuM7qrwdS1fdWmH5D3lrrgz7x1SAWcoG5GnEb8g
         gMK7yfAlSLkn29B/+fMqeSvYaud2TpzdCeKYM+tFH0f8KLRSsVRKz9R0xa710Qq/Illv
         X9IkzyjyYQfF7aYLBk4TMEoSjnhw7f+xZYyF1tZLENBBObXexPMPRhqfjGPzQK+AtKYn
         ZTNw==
X-Forwarded-Encrypted: i=1; AJvYcCWme1cdEt7fE4wLbnvpKcWBkvxMTmLcPMn4iBnpUTy+svFpEaUITxVP8q9XlrAs2xDMSA73V+/WuSSdnVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUGHDWKmKtIZHP71Ei52+twScpVyOn5K9z0CMtBOWyYTObO7f
	vC3AzQkxDA/+AQ+oqdAtj1d5O+NXn+fjL/G4eLgdgiUWJ8yVGdvyDxy1LqgwifPbce1eNsl5cYa
	tZhu4ysMCVFC/jplCJveXIRLW+WCIA4/u2CsQo9D+
X-Gm-Gg: ASbGnctUSqEEEns93iRwXNjhUo/vKrP+4t3CbtzkugUfu50l/dO0MjWo2gQ1fViYBps
	ibGCiouVy9QFv1VPWYiJEHhzs+NEmg95H/aGM7lo7UpbyOnFVSS3DeC6a5sUU6RwQn8hsQT1rpV
	qJcXRAzCwtprSA+oyVcRZ5aMDslHEPF8LFYtjLRsvcmK3THHs73x50/oyhBPoVjy/vZ8o9pL12N
	7+shi8hfZ3+QTd/QPLf5QrMIgVKlkHFr30u89KWKHk=
X-Google-Smtp-Source: AGHT+IHwBiV9LKyHeujCf++SDvt/C0wOTrdrnbCdEByYNIzOd4yKfC34b8rjHF/8NpB89aPcS9hAgwqlaAjIQWQUY38=
X-Received: by 2002:a05:6214:1316:b0:720:4a66:d3e7 with SMTP id
 6a1803df08f44-7204a66de85mr63437046d6.26.1756894589045; Wed, 03 Sep 2025
 03:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-3-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-3-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 3 Sep 2025 12:15:52 +0200
X-Gm-Features: Ac12FXymppW_352dPk8Sx6ooy74nYo3Wzf5MB3L6oworaHp6lw6JSbbxp82YL4k
Message-ID: <CAG_fn=WNHYR0J2oehz4gO8TB2HADb8qG0q++y153Jg1d2GLfYA@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 2/7] kfuzztest: add user-facing API and data structures
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> + * kfuzztest_parse_and_relocate - validate and relocate a KFuzzTest input
> + *
> + * @input: A buffer containing the serialized input for a fuzz target.
> + * @input_size: the size in bytes of the @input buffer.
> + * @arg_ret: return pointer for the test case's input structure.
> + */
> +int kfuzztest_parse_and_relocate(void *input, size_t input_size, void **arg_ret);

Given that this function is declared in "kfuzztest: implement core
module and input processing", maybe swap the order of the two patches?

