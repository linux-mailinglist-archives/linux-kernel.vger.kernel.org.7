Return-Path: <linux-kernel+bounces-827757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F34B92A50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AC77A55B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11C531A545;
	Mon, 22 Sep 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EMZMCUwR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FA3126A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758566923; cv=none; b=MgDDViAK25FDNn8x9F9CTRvDgfCcUwza5OwwIAu4RaYERr9RNUZh8TXPzcgdbSntjLgKn27wCmaoRKBkoe9yk1+1K/oo4+Dtky9TI5E0Mwzf/p9bjC3Bj0vX8njRB84IrjTLIxcILpls3dNqAuneTldziAqUZEhxpuVO4N16dQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758566923; c=relaxed/simple;
	bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7RyhGODTLWJxYGebZ69p2h0UoKuaqeVYS4cFh2Zk1CZVn0yJ7sHnN+Og+fKfyToIFcGEr8aR3H/FH4kKR+K4z5dxky8fRYcuRk84PxQLjMYJrzS0e9rI9ns6iqYJofs+TNAMLsswnwRDt98X33Ocqwsc+bRANvPDfcMvUpMLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EMZMCUwR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7761b83fd01so4389413b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758566921; x=1759171721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=EMZMCUwRqkqCT7w8Zq8rDm4OrkZdVUjuWagkuWRFgsBEcR4H0ab3y255zQb8kv+8Ku
         mI6iIbZXgUt/HcTQtAXojjSmTFH5pEDAV/unjNJ1AQbxdtTAvt5gWZ0uF+8Qll98vd/v
         CUyzL9+3Z/ozswqE+LwhUbfGoUUkQLfUckDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758566921; x=1759171721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62BWT+ChZietzG21mZwYd1nPiVzg6h9wIs2Www+JfAc=;
        b=RpQQsVQnFwWYmDbrIEG3SdpHHiw3aofE2BkEHb4uleUaxoQY/0zgYZC46I5mfOxpYI
         kmb34jzJm2U9+dX2DnZGI89ZfigmHvw0iN7u3K0Bd4txrDb8RD3BBJBx3kE9SUQZtgNf
         pzsF74+XIwSojCJN6rrxrT2BheDFuRnYu8wT5LNWV9jOXAFjy5smqMIGDNRNBs/ih/sq
         cJepfgCoO7perO9pMc0gZ2LIwpDaYoe/CxdZSRa8ZSY2IXTHXYtjpfbqL91DyJZqMIqA
         YvjpRrlF4n0VBczUYAnVmKYzKBWahz/fnaTWip4jMBBfuautQpwQHjk6zFy+3naseg1r
         acBw==
X-Forwarded-Encrypted: i=1; AJvYcCU1cI80xD2344eqjoJOn/65/Qsod5Roa3n1GtV9htjMdKn2ZLgbo6b605ih5tIha5jrrW84hsWw9FI6dqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfhzSgTGvKeqOQjPAVfBIG9y48Bt0Td/hta6s9+P2qzeidAKiy
	FIVvCCNfkbId3GB6dCrStmKZZIYome+IYsdpN//6NM2PoGWpKGukxCgu45hIQDhC3A==
X-Gm-Gg: ASbGnctlC3NloGA7fV5ETnsdjuCuoe/vZl7/3paI06qBkdYoxI54h752nuEzUvwtJEc
	eaRp81rseADOx8+xqfG9T/zQob7VAWgu1pbOC+t2M0JwM+i1PZGF8PWWMGfdxp8y+i8ZrStzlkc
	ywHnZDLYs2oVbpUNuFID2gRSF7S7JsHgnE/A190s4cDyvdHmoC5FCQFnmMeV+0m+5h8vOixqjoU
	66/vFKUinUh0Yj7iZjUaig5xWk1JntIK8YjD9zih9k8Yt6rQT24qYsgvnmjGGaFN+FfixwzNEVk
	sBk8R8gadXr5d+tREKKEMb3FRAD5LFDNwpQcmSVkPkDdvzu0esI4kq59/um4x6kiXMr4FSC8NIn
	SIM01y0vKTPMJowkBRh3zSH0ob3uIdbfVbH2LJEmGUUC4xBNNSSpsZcJMJCfK
X-Google-Smtp-Source: AGHT+IEwQZB9OJP+yIk47lHkNRnpblDU+mAiC3pniWHHE9+nReBcI884SHHQG9F+tJn/QrVZqfu7fA==
X-Received: by 2002:a05:6a00:390b:b0:73c:b86:b47f with SMTP id d2e1a72fcca58-77e4cd35838mr16708833b3a.4.1758566921098;
        Mon, 22 Sep 2025 11:48:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:f126:ac9b:b8ac:e280])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77f34d416a9sm4169794b3a.101.2025.09.22.11.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 11:48:40 -0700 (PDT)
Date: Mon, 22 Sep 2025 11:48:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 0/4] PCI: Add support and tests for FIXUP quirks in
 modules
Message-ID: <aNGaBiUOb6_n8w8P@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <aMgZJgU7p57KC0DL@infradead.org>
 <aMhd4REssOE-AlYw@google.com>
 <aNGR0x185VGHxSde@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNGR0x185VGHxSde@infradead.org>

On Mon, Sep 22, 2025 at 11:13:39AM -0700, Christoph Hellwig wrote:
> Controller drivers are a special case I guess, but I'd rather still
> not open it up to any random driver.

I don't really see why this particular thing should develop restrictions
beyond "can it work in modules?", but if you have an idea for how to do
that reasonably, my ears are open.

> When did we allow modular
> controller drivers anyway?

An approximate count:

$ git grep tristate ./drivers/pci/controller/ | wc -l
39

There's been a steady trickle of module-related changes over the years.
And several modular controller drivers predate the
drivers/pci/controller/ creation in 2018 at commit 6e0832fa432e ("PCI:
Collect all native drivers under drivers/pci/controller/").

> That feels like a somewhat bad idea, too.

Any particular reason behind that feeling? Most other bus frameworks I'm
familiar with support modular drivers.

Brian

