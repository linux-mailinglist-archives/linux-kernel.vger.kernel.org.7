Return-Path: <linux-kernel+bounces-748187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D60B13DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187323AF441
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5BC26E71A;
	Mon, 28 Jul 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8UiF2Yv"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74900282EB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714275; cv=none; b=ohhTxBpTmIugiHX1OYfynBTjO6y0+X7wegE+UfOj3FQ6HBsvvWF09SHVWD2xwGRQcCsrjFcvjknoenvSf7RG9afx3mg4k9NBgVvW09I8HIlihxcVlvjWL7uiS+P/0uysr0NkwUR2/vzLcAvjnl+VchlZrdsi3jr/oAiL4i02ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714275; c=relaxed/simple;
	bh=hkPeZiE09VkneIJsQ4da34eLPfnvqqz5siWCDho/NXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZscoyGXLF0CX8LZUPQ2LRjtL9klAJkGg6YehJSJtBJeGqp9pvcfl1IKWar5LBB6sR3RnSGFcGDRzFxlJ5WV8mbaao6spjNu31J9kFo98L/ES0rVCyakzZ/QposqLUwJ5OgkShoXt5s2Ylp4s6YZ/Ta7DL1ua4R316KNdYaNNo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8UiF2Yv; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-719728a1811so48123887b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753714272; x=1754319072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plhcie/uWEJ2l8MLaYw41+bnUS5YGYhxQ5JWVcQv7gs=;
        b=T8UiF2YvfXnnNZLGjclTGc+IyQmgOKY87SQcgrwPdwAJm81zuk5jOWxJ7ytwrzF3QH
         BwmDabIvXTm2/nHp1ocUKwCI4HJOP5sKb2wn4iOixKWRQr6wQpjwM/O84DkpIs8iNAcK
         OqXeQ2+1L1Jfm5cB66lr15uQvbX2Fjdvabfwkc5W5wxkQfWIAWrSijm7//JWueKoyro+
         acFYNZxcbILcHiP3CNtz7gaMXYilzfoKn7pEhK+staeTz0eaqqJJRRpy9qtdQf24F7cU
         KSSh8lrG9suEoosReAswzgLV3sBlswy2v9injIptQBZZ0CLkHYvTNvQdpg+Eajg8lfkt
         zh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753714272; x=1754319072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plhcie/uWEJ2l8MLaYw41+bnUS5YGYhxQ5JWVcQv7gs=;
        b=d0tjETIpLROx0TpxFEjJEzI5njuZasaCgrX7XXIJ0pG2XYL/pZwpS68OchwDh46iwK
         fYqlg8XFIhbF3aKgYx/7PRFM8/P8RO03eJsjz/BsKMuqqMs6lVGD9lCP4UKaf5xRAYbX
         lt7EuFU3hMDWyLl8zlGRSo4PP/25Je7n8+5vBECIVpWlB+Y9BIDFfgKR3C+76H6I/EEF
         XmFSD2ob277lw3RGAT8ysG2ye9wv1DjVj2WvgTOxNHa9nm9pKTWhD7l2NlYPmO7Fj+tZ
         UQYeV+HLsd4jOaEuQWHNNg/W5NwnsWj5fc9xfWeeQIZdz7yH4+E43JWO+uP2jgSrHmeS
         S6+w==
X-Forwarded-Encrypted: i=1; AJvYcCWddJL8qR0D57YVeBwAjpCpAARVFxjEEfszL2C1IMcEN05YG/Jn0SdtBhRpfUqCG+RFeuqbMOMwoF+3bps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCXOefwPnwR4RJdfqIjITrh03PEtZY1jmFYzWM8UoYZ6yOZCD
	pNZiLYSr1wd6PxhAhqzgZBph6WvSVJTqVjgabQt8zCGBF0+G2kiQ8t8I
X-Gm-Gg: ASbGncuAzyJp20dlSTctfPrNr52tMo0PnwE0kwzpzrZ7/cEvkqSG9nvRGAtUnIZRG61
	5LgX5qG5taYWQ4m9nKGqsIExCdX84M+7EFQ4CLTE/3ANaDgxUiSAxlbebuFku4olUYtB+x9QQYg
	qzz05zKZDpXUt+IEaOTXOaInw2rhTAA0cRvBgbQDHQlrk1zGCIiLq4roVKt+iPd3G5zmjvk5sNx
	vGVUfDU2HVaVa0FAIRPDeYPTUytZOS8BzktxmqAyyeg40/kNHedil25dBY6xYOCsjAH4jMFsy0U
	bYw3VtbGhVnBZ2HixVhMDw3YtclTSQ9oTGDxJRVd5xZ9X6RhrvbUSfI5nRsGOGb/0EfOF6+ArM/
	pKyRUPECFZHsPdA4ogf0kbA==
X-Google-Smtp-Source: AGHT+IFqruB0onDGfKbcBKOJcNNcVE2gI40uibzJ64RLl9KiQFHtKm5sGT8a7BgrgZDLUKDPK7Q3kw==
X-Received: by 2002:a05:690c:610a:b0:719:e1de:806a with SMTP id 00721157ae682-719e328a757mr160433217b3.2.1753714271906;
        Mon, 28 Jul 2025 07:51:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f215500dsm13050867b3.10.2025.07.28.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 07:51:11 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
Date: Mon, 28 Jul 2025 07:51:07 -0700
Message-ID: <20250728145109.1524733-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87ms8p2iop.fsf@DESKTOP-5N7EMDA>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Jul 2025 09:44:06 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Hi, Joshua,
> 
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > The zone_reclaim_mode API controls reclaim behavior when a node runs out of
> > memory. Contrary to its user-facing name, it is internally referred to as
> > "node_reclaim_mode". This is slightly confusing but there is not much we can
> > do given that it has already been exposed to userspace (since at least 2.6).
> >
> > However, what we can do is to make sure the internal description of what the
> > bits inside zone_reclaim_mode aligns with what it does in practice.
> > Setting RECLAIM_ZONE does indeed run shrink_inactive_list, but a more holistic
> > description would be to explain that zone reclaim modulates whether page
> > allocation (and khugepaged collapsing) prefers reclaiming & attempting to
> > allocate locally or should fall back to the next node in the zonelist.
> >
> > Change the description to clarify what zone reclaim entails.
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  include/uapi/linux/mempolicy.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> > index 1f9bb10d1a47..24083809d920 100644
> > --- a/include/uapi/linux/mempolicy.h
> > +++ b/include/uapi/linux/mempolicy.h
> > @@ -69,7 +69,7 @@ enum {
> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> >   * ABI.  New bits are OK, but existing bits can never change.
> >   */
> > -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
> > +#define RECLAIM_ZONE	(1<<0)	/* Prefer reclaiming & allocating locally */
> >  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
> >  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
> >  
> >
> > base-commit: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd

Hi Ying, thanks for your review, as always!

> Please consider the document of zone_reclaim_mode in
> Documentation/admin-guide/sysctl/vm.rst too.

Yes, will do. Along with SJ's comment, I think that the information in the
admin-guide should be sufficient enough to explain what these bits do, so
I think my patch is not very necessary.

> And, IIUC, RECLAIM_ZONE doesn't mean "locally" exactly.  It's legal to
> bind to some node other than "local node".

You are correct, it seems you can also reclaim on non-local nodes once you
go further down in the zonelist. I think my intent with the new comment was just
to indicate a preference to reclaim and allocate on the *current* node, as
opposed to falling back to the next node in the zonelist.

With that said, I think your comment along with SJ's feedback have gotten me
to understand that we proably don't need this change : -) 

Thank you, and have a great day!
Joshua

> ---
> Best Regards,
> Huang, Ying

Sent using hkml (https://github.com/sjp38/hackermail)

