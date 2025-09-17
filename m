Return-Path: <linux-kernel+bounces-820298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BB1B7DD76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2824E3683
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946D530F934;
	Wed, 17 Sep 2025 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ae5bO+YK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AA30F816
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099468; cv=none; b=rzOeiP72iZNfoGzyzrWFR7HwyROqniLV8AhyUtDDOmqW4og28pLLde7P3peepcQicyTqCQg2dCBbvjfWQ7W9Yi7J22wfQzKidXvNlsVy+PNRjnQ6zr6OLZinFi0NXftS3i/VRu4+E0Ynt1wejg9wl3hPVK1dVPEqcfbhDWYaMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099468; c=relaxed/simple;
	bh=MLg7r2ATkj8IHYRK/rNKpAVZF59OC4SkKpGg+Gfzyn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t55umq5znDEfgtKF2u6Cj6QPRXV163N15ftkjppKSXcvPVpnP5UcVEE8iOJznq6dSt2kDR5aUsH8t1IBB+/iEZIFd7U63wfuypRgH862DKBlEgq+kjE00aj6rSq6JyCauVnpF9OTx7pPKv6mLAXN6hgl4eLzFbS09HsXEzzvBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ae5bO+YK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0428b537e5so873319766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758099465; x=1758704265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PjYtE4P/cQ/qbngILdovhOjF67lkoSQw3oPveSlFXiE=;
        b=ae5bO+YKfxRntc1m6BeZmHq97g46e06F0g+t/4VMgPsS9OO06Gxre6EAIvSUkXLMNb
         cx+xDN4WKJzQC4nB+Es1XZ2PQpYYNXx28LwTMpjwJJE5/sSSCN1wCn1UDxeFWcBB65gu
         FDro+PBVvZGSqR8hJ0KQ6Orlv5xB7SGr4Vsfnly7iham3tNlSdBLZq4fIiSHWJrOL5M+
         f5SX71w7Ot+2SqcNz3A8ub5vw1Ohysk4BcLUNxB8q7FYjooL3UGu0acSRq0pdfpoWBjf
         UU3c3OcrwE9Mvf5m8eG86XpJ8p3AiLiOd+gW0S/uqP9eSSUtUKNLdIPCHrXlG+pooyJ6
         z73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099465; x=1758704265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjYtE4P/cQ/qbngILdovhOjF67lkoSQw3oPveSlFXiE=;
        b=YDcrXZAyNOABbXXPioStQq+Q4SyhSpV30bg9wgdBAgKvUfcvoCq00vEKxp235dU6rZ
         m/syrLLfnjrxVqkckE+Yv+8SG+FZRiOke3zptfc9lRDoIgqCb0G1qQir5wUt/ns0/osG
         7/9j+NMf3GXdBUbwQG+TtLlpxb5ur9yuEOP2IFaEZL+wlvr9z/EDZ4N3zX0g1/3yxjJl
         ugX2vEyexSoL7/mU1/NHFrgpvLfgOb1SZYxQ+s/xHSmBVOe/Ct6d0DeKjLtJbApLhY85
         rZnb56cY0LSf2ZZjTr4WWOkVoFl6QizmSsuX8tahuQv3YbWun9X2RIbfbqOHjwQZBED2
         aWzA==
X-Forwarded-Encrypted: i=1; AJvYcCXMOW/lnt09P06jJeMFbtCMF71TnS1iDeb0iXuwZ0pZA/wrq8L4so5NMlf/kZX1TQj1nZOsfP7VC4Dcusk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEn57SW1fXkIXUKe3KCGQPPQewZmGGhKNmeK3SpZtTzCTorpl
	/nxybBQVYLuidOqFU3i5bkEXtnsY6/b8mhZCw7uInUB6FeEGSeEIuys03lcSxtixl9I=
X-Gm-Gg: ASbGncvWIGsq9rU+ClKP8ShyW3hk/my8JTjA1zF0hNeekYdrCbSDPZsUYk5B197YDKM
	Wrc25pSG5ulEWYEtHqWTtu/n9kObz+eLmT8Le7kOhqoW7DC7N0B4DyDoE1h9pd0MalbTz+0xJ6+
	IWB/iJa8elGO6JbztwObc8Cyl4/E55RljKZh8UpwVs8atNbVtcQxN6wQSp0Ow2+zwzYCnL+RG4B
	ShwOnDdwN4dclj1hzVh6bc6O1mrMwFLZA7KUV5k5hSj0h2EHftAdag3izpV/tEH1D0pl0SZykrx
	it/ZWqkZfroxo1PW22uCvgvrOjHUdOzGkOkTEdg6OGzVE/4AJGr6t32RVLvYKA6RG9i9aNYn8Cj
	CCl/80aWR6eehmTj92CWJo2TgBA==
X-Google-Smtp-Source: AGHT+IEisUorRyA4Lr6r4Jw3rzCrqWRztZEO/ay2mckkye3Mwe1di4sWIhKGtMj3jhznPFKqyH4Jew==
X-Received: by 2002:a17:907:6d0e:b0:b04:9822:1ab4 with SMTP id a640c23a62f3a-b1bb6803336mr188200266b.27.1758099464852;
        Wed, 17 Sep 2025 01:57:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd56fsm1320000866b.65.2025.09.17.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:57:44 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:57:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH v4 1/5] printk: nbcon: Export console_is_usable
Message-ID: <aMp4BrEpqXOW9nam@pathway.suse.cz>
References: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
 <20250915-nbcon-kgdboc-v4-1-e2b6753bb566@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-nbcon-kgdboc-v4-1-e2b6753bb566@suse.com>

On Mon 2025-09-15 08:20:30, Marcos Paulo de Souza wrote:
> The helper will be used on KDB code in the next commits.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Nit :-)

The ordering of the tags is important. It defines the timeline of
the related actions.

The above ordering might be understood as that Petr reviewed
an older version of patch. But it was later modified by Marcos.

The expected ordering is:

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>

It means that Macros developed a patch and Petr reviewed it.
The patch was not longer modified.

Note the Reviewed-by tag might be preserved even when Marcos
later did some cosmetic changes, e.g. fixed a typo, formatting,
or rebased.

Best Regards,
Petr

PS: There is no need to send v5 just because of this. I could fix
    it when committing the patch...

