Return-Path: <linux-kernel+bounces-836823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B486BAAA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B013B0774
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D97257839;
	Mon, 29 Sep 2025 21:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hP6ut+mD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8023D7E5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759181741; cv=none; b=GX2P7g8w6s+oLiiQynwA7aCWjgcdIVXR3d3CBggQCpBcqa7ybY5eoiXAaiNZx4pfT446mYu7QqO2zLonhleLZCkDz9J+XClfYPaRo9Hv95BdUcIiz4oyfmGxPzTSTsRIn+7sQW48WAOij/GQKeeFcf7Uy2c0wDEp4yeLaCnySo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759181741; c=relaxed/simple;
	bh=66+ImCS9s5O8hibzo78xGbhfxDpDVb0wuaO+c5fS7G4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qstgSL2YIrFTnpXcVfJAY7wDa2fwBrdYCkJKbh9YU149d0x87wWBArJQEFkEfNlzCkLg/L8maCfuYfyXIOHsp1UJGXhOlM51BGk4FK7KoGxLFNnnASZWof1lb+ih3bChLq7LW9qrnl2gUanZwaeCqwwsotoctq3f1tpTGVwZxEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hP6ut+mD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6365c5704ceso1137093a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759181738; x=1759786538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8sA6CNO1bDnDziNleAS+cBDGZ9VDerULmylgqhGURPU=;
        b=hP6ut+mDlgFwY1xAd4AGYS4r+s6bFbuu+ukwYQCFhpgoBhrLIQXGIvHIlELGlxV4J7
         1RzzYieITxHxFsETgb331y4p4FlZKckIKNc4eBJVpgxtQh5dJmLqqmxdJ2exDjc1F3Q4
         ey6dpIZ3K28m7qfWOYCtkTMdxN6toabA7w5U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759181738; x=1759786538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sA6CNO1bDnDziNleAS+cBDGZ9VDerULmylgqhGURPU=;
        b=rPgkKq+oZwFbs7BoO/zuzuW8hTKnfR2lOoJ/1oWTlt0yjfAt73gP0iLI/itahv3S1e
         CKZgUvYtQOvCNlwlFvmLZQWAkVfUeGxE1WhUOKPUp3f+sdcq7eR5DYNrXUKiPJiwcvEL
         oULcwJEJEw5AxGUQDKbeeDdCOz+lEZn1GcKlSeBQM9F8KU7xZQw97gnOLw/TUNd9Il5K
         6vnl8i68fNEsOI8h4OZ2425PgLmie32qGpRyDNKOYJvo4J9QqkfvC5bytXdEiT1creDw
         l7/NZ3aXmBbzq35y+S0KtilBSrxITP3WuoMSWz+zHmyQwzJlgvlbp7Tj1CQlKXDpe0Fr
         Arog==
X-Forwarded-Encrypted: i=1; AJvYcCUdufRT0avPVtTUuStmuJ1io2WzAsGWJGOd9+meX12NFHLoNzZc8DD+u8QotH9q2H8LS8/9ZUfQW+mCfi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHT0Oyzxb/roxOrekunJ1quE9DQHrdoqAKw5As/I3sWbt+B8wa
	z62lY5R4qzq+32fXbk0l9mOLICCgocfYj4XWd10jLkFkZizz7FiYlNq/VjxJeybqjeTvwWDKcZ/
	IhmURt+YH7w==
X-Gm-Gg: ASbGnctCiIrGKbcYrX4hUrQUVcRBlCc55+Jstud5KGMmVrQxoQh+jBdKq9mbz9z4I3q
	SXQQXae0uz67YR5z3qSEkNooNhyLMG9K5tr1wEvAFRga/OMBeVF/I4peOGQg/xqa+v0Peb40Y63
	PgaPWC1zfdjQ8Jqa4ECTgJ11VLeUdJD0k9wUbc61RlevbJidlJqnC3xJVFQpksJzd9Pcme8sIdM
	RuCishZRvyB0JRTt/oOOEii8NnAJ0k1R0rUkFsIQqQ2QSlEe2jtGoaSxC3mrUaphvNcALaVwW72
	kXuzbCFzXkYFHMQ9GW2cG+DQu+jzLZAXzwnzplMbDNCHfqmQ0yYR6d5Ac7qE4y4+oDwee2MTCj5
	DpfUmJV0f3RZxnU1J3rgu21OiXZhMpVY1bCgHk2Bh3uTZCUjVu+Eg1nXqIoVhgEUNcbgNQTan6V
	/jHNTwn70zmRgWN5tUFA==
X-Google-Smtp-Source: AGHT+IGoOUBZnYwnYWOBmqzq+cDPtF9G0eI6oSrLqo4VNr+CCl8QluuL3cc/4pPjv/43miQSbirhYw==
X-Received: by 2002:a05:6402:1d4c:b0:634:a84d:f76c with SMTP id 4fb4d7f45d1cf-634a84df7a7mr17602035a12.27.1759181737663;
        Mon, 29 Sep 2025 14:35:37 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae3227sm8715597a12.28.2025.09.29.14.35.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 14:35:37 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so322419066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:35:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJjPw35M42d2VGuToR1ojhFA4pj98m5XyMG+MbewpvAdpphDwpXVfY5ZmXS1hQ1nDqknWhian23kcdbDU=@vger.kernel.org
X-Received: by 2002:a17:907:2d24:b0:b04:2452:e267 with SMTP id
 a640c23a62f3a-b34bc399695mr2148100466b.56.1759181736296; Mon, 29 Sep 2025
 14:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758696658.git.dsterba@suse.com>
In-Reply-To: <cover.1758696658.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Sep 2025 14:35:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuu2-7z3ALpt6v7L3Zoa_cqz+imGNGwaL=QPGLw7eKNQ@mail.gmail.com>
X-Gm-Features: AS18NWAs8zD8K7JSR_3PPFlZf-NPA9cZPs8jLwEZYioNwmDaW4kMauzEDvSDsho
Message-ID: <CAHk-=wjuu2-7z3ALpt6v7L3Zoa_cqz+imGNGwaL=QPGLw7eKNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.18
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 07:41, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.18-tag
>
> for you to fetch changes up to 45c222468d33202c07c41c113301a4b9c8451b8f:

I see the for-6.18 branch, and it matches that commit, but no for-6.8-tag.

I suspect you just forgot to push that one out,

            Linus

