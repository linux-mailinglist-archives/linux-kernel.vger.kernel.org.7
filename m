Return-Path: <linux-kernel+bounces-755729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48AB1AAF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 00:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F00A3B3D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AAD28D849;
	Mon,  4 Aug 2025 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKXTC2/Z"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA118D;
	Mon,  4 Aug 2025 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346658; cv=none; b=KGjYUNJ6WO7TjbAZAbDKQZZIim9uMMNMdCeXwQao9Lcf1A9d/Rv4ahtUyZ2LF+PSsUnIpMMIrrWheXMHhivplJ0J+/3D7DUNU/xGQQcvjx4niNC82J+GO5DdZzElWDxQdK2rOxG6BWOQfrWBwDR4/4bNaQreqPvgKTqK7sJgy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346658; c=relaxed/simple;
	bh=PQsZYFY5jZCQz0YGqm2FTfg5CUxJkyoBF1S6CtAjL80=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BDBp7JIkzP426qkwGOu3dNUqvzckF+Tlwl0zFfRmMfWx1k60tK0cPHk6mOjSNShYfuaqyCJ9C8Ng4i0p8hLmBxX/jrN389KnXSOsCq7Uo2J2EwaXCa9vTuaQpJLTm7ZUGcUPTPXmyKLDDwn2D6A0JGSkfk+h1e2GgpOGAXs8HXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKXTC2/Z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso7593890a12.1;
        Mon, 04 Aug 2025 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754346655; x=1754951455; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVhJ3RUF0RZaJxnE7w5PWJTBevCzQWc213nyNqZetb8=;
        b=MKXTC2/Z6+5cPtp1wAVaRQfgL9/brr12Srm8F0YwVnlpj+2ihWtf4Tzq1jNPRqQun7
         iA4cR8UhNqwpPhm+Petylog9ZFLxD/JYi96mPkpXo2j7VHOngLg/m/2Zph7pjwK0Hkjg
         Yr65TVorjGrtGrMBph86KJ3G9KxfRNQMBhFiPbcnxaPNi9HFKjRNB2sB03EPN+F40dfl
         ZVZSgQ2u4S3piZGov+85FrB080UIq87rewcEuYlznuG5e00J6mptaMHKlzuom6zp/zDT
         eqrIr/X6b7oxP1F9sCteFElsZrdvnZ/M61yLYdb0Gvv0h1cgQZyaVq7ov1s4NmhJNLcW
         yVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754346655; x=1754951455;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVhJ3RUF0RZaJxnE7w5PWJTBevCzQWc213nyNqZetb8=;
        b=YBhUOD8SQ+Kxjx/UeXyOZ4Pf/pFtZ//+aq1heI0cI/vlyQIY08Qzx/Xscgl590aPbx
         DHCY7AdY5OWyRJOj2BAK3EWQhxxwg/XyNXk5Q3K0YVkQYaw2s9MZ/nXBJXxrWyvPYkrM
         dRxskdEecVdpgyOcEUeSnnKYmwQ3eO9UandckuP92iARH1m7KVtjcinVv0lA77UrPPF8
         AzQpsfUAiifzfEh0WrJwLP4L06TtcViCZ+sagaXkJLO8r2kLCM+1dWoPG9rvjNoLgnF9
         9EippCNgQo98Bve9Z4m/lBS/mAaMsF9ajZEQsJsNTk7Bj4DuXLJ8/Bn2Fe0lUXd45GDT
         rzqA==
X-Forwarded-Encrypted: i=1; AJvYcCURJpR7HSpip7iIQeqpjCfGlu0uJDkGx7c/wb5lriksiRBA3xVt0svitMWEnQEipsN/YR3w5LP2deI=@vger.kernel.org, AJvYcCWL65aYhoya85jRJ9R02jHSN+Y9vcTM9jJbpnicOqWNtUhJpxC7pl/MX7i5bJxtEPUE9Ge8jnkVEZsSn8SA@vger.kernel.org, AJvYcCXMo/673ZObjayJem3g4kbTaQcgd3OPvOR0tCHOqsUJ6WZgwFhYjO4ltj/IjghKP76Ou/MWFYC36oa6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6pgziuhAoTxr4XoH0kCQVOKG1tR+OIcf+rGfU9VinsLXtE5pU
	J9Rv64s/HWu4GCI/92OAnxZcjVxqh0Gd46fjLoJvqCm1mm9rFBOcTzjx
X-Gm-Gg: ASbGncthtcn0VLAR2btksq6hgTCStv8NErqrE9Op5RF8zuwZaMxbdwHFWKNPgoJC4aG
	oS53vQjHrUkQFM3P1agORKJyHLnFlmaMqr2xqUJRjt1m59pANKUg53oPKxXwnYAnC0VBZL/Cdh9
	MHkFLXWKzX4MUMyX1wBpxMwx4cJqEYM852JeGxNPtank4aZsNAgiOZpu/3SzFFBssCLhQhGONue
	kWe7LNLAj4xsiMUPb5YnWmEhynLuWYPdg8m+u5YhxfSwGg6IYhxIQQ7eBA860MOsWF81iC/WvjO
	XCBVhsi4q6lRjkRa4tBfXQ81Y2X20XFAfkWtRv8M01YYlG/Dgn3o3g8GKvndNintLyjEXEv5hTp
	gKlBoPA==
X-Google-Smtp-Source: AGHT+IF6laWTEHkXe3TQTV4Eg1F3llISJLS6HnYvNcKWxG5Q0rLrRztncGkk/tht0H7tAzIlvGz+NA==
X-Received: by 2002:a05:6402:3481:b0:615:8f10:2d4c with SMTP id 4fb4d7f45d1cf-615e6ebb00emr10340144a12.4.1754346655015;
        Mon, 04 Aug 2025 15:30:55 -0700 (PDT)
Received: from localhost (twin.jikos.cz. [91.219.245.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ff9fd1sm7339006a12.44.2025.08.04.15.30.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2025 15:30:54 -0700 (PDT)
From: Jiri Kosina <kosina@gmail.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date: Tue, 5 Aug 2025 00:30:53 +0200 (CEST)
To: Steven Rostedt <rostedt@goodmis.org>
cc: Sasha Levin <sashal@kernel.org>, Michal Hocko <mhocko@suse.com>, 
    David Hildenbrand <david@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, corbet@lwn.net, 
    linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
    josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
In-Reply-To: <20250804181447.0c518b14@gandalf.local.home>
Message-ID: <alpine.LRH.2.00.2508050025060.22517@gjva.wvxbf.pm>
References: <20250727195802.2222764-1-sashal@kernel.org> <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz> <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com> <2025072832-enrich-pampers-54b9@gregkh> <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com> <aId1oZn_KFaa0R_Q@lappy>
 <aJB8CdXqCEuitnQj@tiehlicka> <aJC0ssMzX0KWnTkG@lappy> <alpine.LRH.2.00.2508050000580.22517@gjva.wvxbf.pm> <20250804181447.0c518b14@gandalf.local.home>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 4 Aug 2025, Steven Rostedt wrote:

> I know we can't change the DCO, but could we add something about our policy
> is that if you submit code, you certify that you understand said code, even
> if (especially) it was produced by AI?

Yeah, I think that's *precisely* what's needed.

Legal stuff is one thing. Let's assume for now that it's handled by the LF 
statement, DCO, whatever.

But "if I need to talk to a human that has a real clue about this code 
change, who is that?" absolutely (in my view) needs to be reflected in the 
changelog metadata. Because the more you challenge LLMs, the more they 
will hallucinate.

If for nothing else, then for accountability (not legal, but factual). LLM 
is never going to be responsible for the generated code in the 
"human-to-human" sense.

AI can assist, but a human needs to be the one proxying the responsibility 
(if he/she decides to do so), with all the consequences (again, not 
talking legal here at all).

Thanks,

-- 
Jiri Kosina
SUSE Labs

