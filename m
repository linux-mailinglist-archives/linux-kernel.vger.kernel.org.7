Return-Path: <linux-kernel+bounces-851207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F99EBD5C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B63514DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CF92D73AD;
	Mon, 13 Oct 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I7eXGvwx"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635023AB90
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381308; cv=none; b=nvklpg5efysnQ+KmScPY2+DX18Gp5kCuBFFK8PLWwwhR5yI1eK5xlGoMkuNxZMnrmzrxAbJc3PC4cokns0jbWrtGQhMx1PNCW0lLvlVZIdvPmNGdSMY8A3fkfuBc0OELI6VfXK6xU9Ux578bHL5ABdMfN/PXo9IQkwpZeI7qn1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381308; c=relaxed/simple;
	bh=0rjtWRe2ST6POuoVWc9sVVBCjY+IxQXjMhFHkJnDz0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUCLHTkbKsl6ws0d3pdvQr7Tmx+P4VZRqwxStkwlZpD3lOzCVJuCE90mwodjqR6eDHRbBWYpbXHrS87Mh2GMlJJub+U/QubyGgPCCQ9XcHPfqUO0OuTX3rDPz6IUL0cf94UM2hNluguA+up4pJJIGUiRFHqg89e7dNt+2w3Y1UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I7eXGvwx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32ee4817c43so3627586a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760381306; x=1760986106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rjtWRe2ST6POuoVWc9sVVBCjY+IxQXjMhFHkJnDz0M=;
        b=I7eXGvwxsC9hd9WQ1Js9QJyZUabM2yER12oZD+qn1NjgichCUT2g+6nGxWXuqDv3pr
         VEeYuRItnOYaC3dMwsa12db6OFBJkz2Fcod0h0jCAjNO9GBdUxHDXPB+zdPckVGInnII
         5wYyom4zoGgZBMrlncvCTOcA93V2CX63mdmHDZjHHuuJs9vw5E9f5Mn2meaXMK+dSYry
         hrrmBsAustQFhwO3qoglOfoDdasDf/1TKSt5kJZLvetAOQk/ia9fhIeMP1Zd//a1RmE8
         uNbAGqhNRJ3FySpcoDF0ZaitR8PEXw1nhVuvXKSvPLbuzuGu8Rkg6PRwPlle/VmZZPDx
         QgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381306; x=1760986106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rjtWRe2ST6POuoVWc9sVVBCjY+IxQXjMhFHkJnDz0M=;
        b=BCUzBQNPoOcf72QrJ3HFXdd67IXw+3i0GKCVZjYcsYZ5w50Uptfp6o300XBJG4Payh
         Zcln/yoxgq+m6UIXo8iGAtij+79UhkFMX2Xo/5TEqlKNsDE7Doq48bX0riP6vqLmU1jt
         s4BbxaZeCG5jRYDENuKNe3PB15IIruF+l4/jAxwo37JAJXNhlGjh6kR1LSxLnxS+WRNo
         0rCktRR6T621mR2Y+Fl0wBBDa8BHk/cCTvid/qOZwXQFurRrG4TweJTPjPTB1Extl8Ie
         p2+HrOBC38yZSun/Gytfz2QsYFEo/xcmC58Tc+blmYkCeSsjVJiDtEv+AEYnKC/fGIzx
         OW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfBtgM/s7sCZvQL7MxLdnTeNLE5sW+VUwkVYXQH4AHY1VC5VijriO67jCfKO2WRrs+h3QSnFZ2hoKtPNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkdJC7MN+qnOGviUF3FJsMGtTuWk5ict0zGfcXDUIYb5MKITb
	3qoocw7GH414PCyi9l8LuK1cU9c5efC2g3lF7/YnM/7Zpj888L+5gOnQqaz8CZEoPkxHkbP9bl4
	w7ZGZIL/voVxg1diYkDHA7dQfHesSsRaPKAC86/GO
X-Gm-Gg: ASbGnct6XiFRGU0U+kHPYPPtANyFU023KaHGG59b+ZnDiuNeeBJ4nIWKKuiylMXW+Vd
	g//QnEYaLWEQ6cO2wsHYeQnv8IGxtSRx/IlM11a4B1vTE2zYUMokdn5M5C4gLmafrWh5NbkDek0
	dfQKBxfLC7ET9TGXOQa45+uVCUBQrgMkbEggo7sHKYtuZOzcHIhBm+E/BMzmj6bYsqV2VUl91Cw
	aCKWm4j71ZbCqnZyU7uSMf3Rhk7PYmD9vkJ
X-Google-Smtp-Source: AGHT+IGZN58oraJKYOel3htu345mI+OrYGHA9s9qA4axG5xZODKhYm0YNJs/VRer0wpLSUpLTcJwFs9Oclh2FLyAP1g=
X-Received: by 2002:a17:90b:37cf:b0:335:2d25:7a7a with SMTP id
 98e67ed59e1d1-339edaadd9bmr33999353a91.10.1760381306209; Mon, 13 Oct 2025
 11:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
In-Reply-To: <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 14:48:14 -0400
X-Gm-Features: AS18NWADP04PjUwD5Bh9EaCBl6eZqSpZ9M9cNZXWZbUAMAyKy1WbW4DhJu7OJ44
Message-ID: <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen.de> w=
rote:
> > Ricardo Robaina <rrobaina@redhat.com> wrote:

...

> > Maybe Paul would be open to adding something like audit_log_packet() to
> > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call the
> > common helper.
>
> It sounds like a good idea to me. What do you think, Paul?

Seems like a good idea to me too.

--=20
paul-moore.com

