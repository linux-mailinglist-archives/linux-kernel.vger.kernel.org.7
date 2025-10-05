Return-Path: <linux-kernel+bounces-842475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04622BBCCA0
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A53BD346921
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6475239567;
	Sun,  5 Oct 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P+JU5vi3"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A82A2629F
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759700009; cv=none; b=EIxg+NG16ttyD8780ekNZhsruL75wG88Hn74YRNBzOxneeQ2iJh3WwUNkOSAIL+y60z+F5/xAuqkEQAN9GMEMyN5+Wr9L9AW65dw40qeHgmCdVstldC+8hre3Qk7HVREUjI2fhFoFAqZlC4FhrH1++yuF9bHJvhK0xEx0Nwr6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759700009; c=relaxed/simple;
	bh=sYYQkpjkjGK2ncnInXxL7Rw7rsHJStWlly2L/iAU1Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPcbEmfCeuSUl0CmoXCVd7dK2cFOGsgEA9RToGl67LirbeLKzinM/+m/3JGwIFgjMpeNIJgkcnBRZSi+tKBnEnmOoBX1VWDBnha5oY7glUK70N/LZ975gaCWknwIQwek+N/PQQhnBu9LXJ6sk6CBF0d2d7+0Lx0wree9JReBTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P+JU5vi3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b463f986f80so541695766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 14:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759700004; x=1760304804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o5xflicGk4SRWq4uI9IRaqV35+qaPk/Vs0aIHyFIGYo=;
        b=P+JU5vi3weEEnSGwFTQlazoKfgh+xew4qtfWg71s4EvAsR8XLuaN/R7Nit2zXMYzNN
         Q7/8p4HXAbi6LOp4BzubIsLE+WJVgjIUya7WNn6oSN7pj5nGFLXdas4EiJwgPLiFPWYH
         GIxnHq6WnEWdCa12Uuo4K1k1j0f9UiiG4z4XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759700004; x=1760304804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5xflicGk4SRWq4uI9IRaqV35+qaPk/Vs0aIHyFIGYo=;
        b=u97w3sCWdMbjF/Qj6EhAuW46EwUDA2tD6x7gQD9dgZuJn2c2oHmC0uHUSe5rmyRi74
         M/vWX7VOvkuC6nHSWfNUCvdol8YNZhbuxouogXuFMU9sw9jAMUF8pnnH07KuhpMTPns0
         3vmkhUiKQDuLwhRysqQlHmx92naup7Cit7aPBsBDxlM4pwan0B9/tFLEAg3KhbzAvZdW
         sJr8cZtzEsJUsrAX37L7GuC5Ycu6v3TjhssQ4SGUt8LvLPTOGQ76FcdbIWDbgmhP06P9
         JzIvrJs3t4YGaiX1mWfY1Ho3jADMmYCv/HENiSZUSlNELL/AMLMjm2y94wxl+/7xGUes
         b+4w==
X-Forwarded-Encrypted: i=1; AJvYcCVk72QrTvoEtci+TRBqg3dlbFjgWWR6zqJum1998Pp5OwlnnRSwCTYky+g7KHP1rGvL9Nqz+yrMZ2o+ye8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5osJ7FALWN1fE3wVjxOIdRbW9arzbqgT98QxMsWlQgQjixSFC
	Dul8Z+f/jsv1kJwC5I2YcqNgp7fkc/9J8DDs8OoiGeK+6rANRXxsK9Q5m+MqSCM/ZLYl+H165KC
	ZYBccDIU=
X-Gm-Gg: ASbGnctWZSGjtt5c3nmrAYnrQexf0ELo0ly0DI/CMxp+aHQ0LPQIyHugs66lDgwmQSH
	fwz6eSeJz1SAMSOKmdTNdyU3DqeRMp7QO7slB7M6snP1+ekxXD+g9OBweOx7KiwvEWKy03cV4hb
	GKG9Z1SbwveOe711iOML5CX3vycCQn/uCEeEW+aeXqh0TW0A1C3gcQDVK5UbCIDdnRd7t12GJZ1
	q4+gj0EDNTa9NMpSHtZOgq0wZZmSTSBGczPGNLU3hxe8uR57/DOTzCyUGSgmKGXcnoh3Ji8JACi
	rbN4I5yaolTppH9i1R4Xjx+Oa2RRdSv8yLbLlqV/AsZeM0q6f5A44S3atwMrac/a1U81Izr+c4L
	JPfjwYUkucxfUeijpXwd+o7JpLctXod38l4ZM4eo3k+hsFHw4dbmkscoL80y7QU3XPqIobu+TUC
	aogHi51AF4h7uRJo/eQl4O78U59YmM9JM=
X-Google-Smtp-Source: AGHT+IHIcHlVh1qTXPkoAqd319iNiAi7WGG7BRimWlzj/9Mq5kGgv3ic65T5DxDanH+GLoGzdEcfMw==
X-Received: by 2002:a17:907:1c19:b0:b3f:f822:2db2 with SMTP id a640c23a62f3a-b49c038fa64mr1360887166b.11.1759700004354;
        Sun, 05 Oct 2025 14:33:24 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b408sm984481866b.58.2025.10.05.14.33.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 14:33:23 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so6025831a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 14:33:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWN1kLlYUz1jSIYqP79tIKYYn95wRIUq1CSls0Melne88j9akb2g5RPmOTx9LgjkoyiewEVeAEemrttUPQ=@vger.kernel.org
X-Received: by 2002:a17:906:c102:b0:b40:5463:3afd with SMTP id
 a640c23a62f3a-b49c0f6e11emr1249670266b.26.1759700002833; Sun, 05 Oct 2025
 14:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com>
 <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com> <3771775.lGaqSPkdTl@hyperion>
In-Reply-To: <3771775.lGaqSPkdTl@hyperion>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 Oct 2025 14:33:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4_zaYJ9ieazt9dnL69R+SL1PEfJtquGVOqsNCVt_rDA@mail.gmail.com>
X-Gm-Features: AS18NWBQQKqi5I2xncYfg6Cw_82qONOSAn3HSxJQcAmMyr9b8ndXyO8q6Tf7U6s
Message-ID: <CAHk-=wj4_zaYJ9ieazt9dnL69R+SL1PEfJtquGVOqsNCVt_rDA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Maarten ter Huurne <maarten@treewalker.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, John Hubbard <jhubbard@nvidia.com>, 
	Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 at 14:31, Maarten ter Huurne <maarten@treewalker.org> wrote:
>
> The Black and Ruff formatting tools for Python use a "magic comma" rule
> that works well in practice: if the last item has a trailing comma, the
> items are guaranteed to be formatted multi-line, while if there is no
> trailing comma, single-line formatting is attempted.

Oh, that sounds like a good heuristic, because that "comma after last
entry" is very much "I expect this list to be expanded upon later".

              Linus

