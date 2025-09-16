Return-Path: <linux-kernel+bounces-819300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B2DB59E52
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189923A66D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC01530170C;
	Tue, 16 Sep 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTMvh5Bi"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB1283682
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041389; cv=none; b=FYdiYv/+Qu6NJ4MHUER5ZwOP5lN5Ipxa47qwqO7TzSCnNvfp/U28HrPdPyX7OpmUi4BiKXrPyfvKUsxaVL3NDw3yccJbZGGUztun9z4JZFqrdTQbJEsmB65/1Pj5eJawQ/d3UnyVWP9S2IYpsON5kjrPSoF2hEpRd7xec8NKPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041389; c=relaxed/simple;
	bh=TwcfabmK9WC+2NnCZx+uDvKHL+px3+cu4KrnzhiY1uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=fkFCuSVH82NDe5KIGzHdHAZ9gzoFwkz1b6tEDjclToiF65241wZXGVpZ+7C4RZbfhtA821zRenKS9sGgvmSbhtb+6GdDo+SwdD3AGxt8kgNLcLraLxvgDO6MyYruGUG+5vTDyNKIHYyqHSN+6ez2cjd4we6Yjg/p+aYMT7GZzMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTMvh5Bi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso3412431f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758041386; x=1758646186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwcfabmK9WC+2NnCZx+uDvKHL+px3+cu4KrnzhiY1uY=;
        b=cTMvh5BiZAQT7XxuqXQALlC0nPbDxLSNPWLLTD6SDCVaPRvLnG1dPSdFZkIaf80UTT
         FZ7dKG3/4W0ASBzyTsgRAxvJWGT+xJnMT4qllBWWu4xnhxHKQr+exMN8pqlMyzDhVThA
         C9mKynrDNjxMka4Xw4BITjSzRZCxh3YNIc6JKlh/3nzoLtnifA0nVZMhrr0tJL6MgXjx
         +PhO5nrvR4A787I7o0Jh+WVTZUQYbHNAQppxq3YdBKe/5MItN/GcosBy3awlf2+JIdph
         qjxJ5RDKwdCYcBHxO40afUcVR1tsdopQVgEBdy/Yui9JYqjWLD/oQlfnB2h37GsqfjgS
         m/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758041386; x=1758646186;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwcfabmK9WC+2NnCZx+uDvKHL+px3+cu4KrnzhiY1uY=;
        b=i1ZszFZ9PK2hxaGZAKu8SfrLBv7/rytkGTV73iCaJAxS9osMyFlINo0YjOXr49mVuP
         OxasMYOEVoyK8/lGHHDfm5nO1O0g1MrZ9KRsK6g5XakM5Mr2/p5JENDFF4QRCtUlfsnA
         PqyRrwk70v/xZVQKklLCkvT3sNbtuuk0/miDRcPqvCPdy6w2Yqm179qf/xExgZgTMQhG
         9Su9S116KaoUJ9muskqohjqQJgxyYGSQibo4nXnXjGszFsRQBUp294ExAD9fvohUxK2s
         UYN6JiZRv3Sn0Q+oiGicrf9VOI44m/fHEj9dWPHLhbhFylCiecEuMgPUuyMbfGUXajla
         RO8w==
X-Forwarded-Encrypted: i=1; AJvYcCUu+pQ0raD7MhJolNbW4GU/C4AqTVpdRMMYg6VuFjnP7x7vt6U/yN6GiYCVTY7fGJqZlGElMj20NqrIe9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgstsgAqARA2Q0tNDzXR8iCq/NRFTZdPatBASZLR0fZS/mCpWG
	mYx0SDm9LDuUTAAWryD1LJJARM0Xc0Pcf3jbp7j2ylUPYDyXKaYmsaEuPwA684yNTuudub0ay7h
	YNSlCfQgvysRNEFHUazbQ3L2HJFgYSt0=
X-Gm-Gg: ASbGnctiR/T9NNmaPT8e2yx5ZjoNyyHGYNSywvs/xL1R9tt4033+JvxVks2y3cRuzYt
	PKeQUvPs8hIRvf3IPK0+DV34UCfh3Igr3rn48wDQ1G0NjdFyhz51Hn39gkFwCP4tSF/khXaD/UO
	EMeVlUv9nIEQGNtPY+46Hd+XNd6Wf63LMOJgYvww5eZXdxlvImdA45WLVvxLGYwH6Mdjy3/cEGz
	kA9PqqcwoLNiwDmwveAgsMwd+VAQcvT+2LG+pN9PpYRG/rnTqvVPp6JAwvpMmZWOG5iS68lBp9h
	gwjMroQ=
X-Received: by 2002:a05:6000:144e:b0:3ec:25d2:2bdf with SMTP id
 ffacd0b85a97d-3ec25d22d48mt4512327f8f.27.1758041385551; Tue, 16 Sep 2025
 09:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com>
In-Reply-To: <20250912163043.329233-1-eladwf@gmail.com>
From: Elad Yifee <eladwf@gmail.com>
Date: Tue, 16 Sep 2025 19:49:34 +0300
X-Gm-Features: AS18NWCrlr2QeaCB--5yANKThME9nJo6aat3FBzn5_cxJNe5mTnDqX1wNE37gpE
Message-ID: <CA+SN3sp6ZidPXhZnP0E4KQyt95pp_-M9h2MMwLozObp9JH-8LQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

One caveat: this change will cause some existing drivers to start
returning -EOPNOTSUPP, since they walk the action list and treat any
unknown action as fatal in their default switch. In other words, adding
CT metadata unconditionally would break offload in those drivers until
they are updated.

Follow-up patches will therefore be needed to make drivers either parse
or safely ignore FLOW_ACTION_CT_METADATA. Because this action is only
advisory, it should be harmless for drivers that don=E2=80=99t use it to si=
mply
accept and no-op it.

Just flagging this up front: the core patch by itself will break some
drivers, and additional work is required to make them tolerant of the
new metadata.

Thanks,
Elad

