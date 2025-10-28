Return-Path: <linux-kernel+bounces-874410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F300C1643F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29FD3B6E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383334AB0D;
	Tue, 28 Oct 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mev9YXuM"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259813321CE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673328; cv=none; b=JQjkLKnjEBEVhPYERvoS9Y72oPhqMYrmYOa7gc8EHl4EFdZOtd71wXpyhft7I7CyMu5fmwiDlpe72HGwwU1kKXF0ED6EsGSi0zcsLYU+KPs/plYDoZR1rTmmCQ5RHTyg+qErFmghZUo6+vXoG9HlPG4MXYqNMtUfj1NXanBIUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673328; c=relaxed/simple;
	bh=Im6VzXUuwdDDmZDQbOVnf4aGedh78bR8cSlODEcvMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb0x4c+tjkVkFn3QcPWh9ugFrJ5o6sjiy4AOu3b7+KFScf/rpi/gQpmnlIhPmeXGzq1r9YD62F4Wma/+nosfSjmrsUolkHzKs0WI97tbo4zhT38NkQqVVZtgCZqwsXWxfxFcl/YMGfezSB+ld5NDX/fkliP3JwNKZrqlvyayKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mev9YXuM; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7a26b9a936aso3700234b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673326; x=1762278126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rXtwgLeN1ZS1AfyQjxZpzxTFmTVASzIiRqR3Osccy0Y=;
        b=mev9YXuMu+qGoKD5lO6M3V82corZbeb3NZfCrDXaH1LDRt4woQP5QwrwwbJkiMJfCq
         1twF+S2v6rhmhlOlGUwYLeGnaEM2/BgKcd3SNbx4fldJXXGfeRm3D2+pT7ZQkpVCQ1j5
         5oYGP1mEviDdX2A/lX6Al9kcOZFJriJIOIpG2hNpSuq0J/+TznBAG48X+99zpOPP4Nch
         4qTwLOqDvGsYmwmuLLlTNpLrg7hOyCh4ix1Xb6MojWH+dzoW2g3tZtbdmSKYBl2OoJsG
         yzjYTY+X9uvCpszPm5kUECSy29R0ARE52nN0Yy/IAbi2ho8QoP5bR5F49wrYMmZBoXJP
         6Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673326; x=1762278126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXtwgLeN1ZS1AfyQjxZpzxTFmTVASzIiRqR3Osccy0Y=;
        b=G7iXprBkQuoCIkAllKFaK3TXwQAiz7usLXwI8GqX09ja6Yo9lnNtmlYoAZ2L2q19ix
         4pFmUre2VlbwqpH9z+yHutdunWe6jizmXQ40OBvkSAALoYGVl1W1SggQLwQ74ttV3Kfk
         SU+6RSinejkfughRTunzsOz83QDs6kFlFUqaFAtJyRIl4xEoVYSpGmCJ12dp2NXcxStw
         ciVtki4mX0upDxX4kzE30z4mXPX+Om6qc74HuT7RrXfFbMz4xZs9E4gRGBHBkeANnk5x
         zkgQzGY3ANMIKuKowfvciVeoOy+XPo1fZ9SB06LYY44IZdnNJ+HvBNlrgMnBkAvEsEE9
         JcfA==
X-Forwarded-Encrypted: i=1; AJvYcCXKqKnu/ZFOJbnCy6iUBxOxlkDkycXb9XGvROMWK8yAylZ4SIIMC6d8zPkb1fDwdDNxFEOjvIBKxqTXNk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6zuqn8QjRz1JbEzqOWELWA3MGlpnu1VrGTOczdOg0lv29hhB
	VuEfC0cH6TJ5RwPV3hDxVVHf8o3hUk7AJYlChP18Ei2w9OYxcjTdIkph
X-Gm-Gg: ASbGncsVtKnhHn9B5CZ3T5u9ef6bOBeYkOyYwNqM/FV1smhfxDjFUssZQaTvoOaBV9b
	5TcnH0usNccrd4cbjR0icITqCv42xJt+Ga8y273R9BoV/M7ZoONza7mThh7ayLeYouixPAblMu9
	crZnQ4lxfF8WvyXLfYDYmbEtq190qCK/Ky9U6O4cT06utAGj3CHrDbulUmhmuj+PoGeT00Zxnuf
	Qrjx0kTwvJNfxwWmQVubgzsxmXJ/5zV0GgXO6y8Uv25Ih7asjR/Tzu6aS1SviTwGelc9VqfcrIQ
	XK/Os9GctPdsa2dHRYbgjYlOfTodMqn6zD3IiErd7kaSo/AgPX91j3+DaaGROrBTgyFP9TqOlA5
	qAGrb95vlK6YTxCd/iXpL9+Je/TJWxMwNDlTsC7WTZMIQwwloTaJRIxkEfGyJpM33EPJM0yDTHv
	eqFt9lLWSzGoEzwa1v0VQ=
X-Google-Smtp-Source: AGHT+IHY648HfWpg/1mCsYtX8S4x0CTFltDo3CpRCwoMSOqHKLBzLVsRp/I93hYx56RK6MNiNgUYAA==
X-Received: by 2002:a05:6a20:2588:b0:341:84ee:7596 with SMTP id adf61e73a8af0-344d228adf8mr5688460637.16.1761673326191;
        Tue, 28 Oct 2025 10:42:06 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bd810sm11197981a12.6.2025.10.28.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:42:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:11:56 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v2] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQEAZLv8V0asoe4r@fedora>
References: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>

Hi, 
Forgot to include changelog section in v2. 

Changelog:
v2: 
- formatting fixes compared to v1

v1: https://lore.kernel.org/linux-kselftest/20251026174649.276515-1-ankitkhushwaha.linux@gmail.com/

Thanks
--
Ankit

