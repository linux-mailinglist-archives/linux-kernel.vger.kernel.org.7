Return-Path: <linux-kernel+bounces-860852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB60DBF1257
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137D01882EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE03126B8;
	Mon, 20 Oct 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWPZ8r8n"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B42EC0A9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963156; cv=none; b=GhkDTzxVn8yTyyjadFzx4h8WCFMttygAT+tGcl0cWntGqHPVjamSbeb+GqysfrIxqN14TrfBRJwmbSU8cnT6iX8KkEkNBVDMHpeQ+EarIdBTslxLFmKcVHukg2L0vQky1ypjRReCPWhMlqKvh9nJtcXrAQm4TOhPXZb0nY9qDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963156; c=relaxed/simple;
	bh=mYoiBwbnX6tEfhbbdu+UYbka5RnyMvCvRTRvJ7uOd/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcpIi11IFJuEeDaTwvrPJfcd5RwgaTFNjtuvfY1tsXOFXtO8N1az1v6Khh6TA8F+1iLGtlqFcMLZLuLU1sftEzvgovFFiD+liNUnnpgXFRSPYFA5UwFiKzQF9lBsSAaLbTj70TlaCJ0nkmI2OgNn+ZgvmLGtk1QTRi01HRa/PsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VWPZ8r8n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece1102998so3865090f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760963146; x=1761567946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=joBbZlAKq9MKYKqmzAoAqjZljgU+WlqDqzpRmSnyPTc=;
        b=VWPZ8r8nejjkDbS8xU/vTG2zTf0VmaUIr+/vN/DwiwoSLYd0RLuNe5You57m2mGhTX
         9jvQSTDula3O2moY0zZGbRqTEcBMDWE6ocsN82ltP5riRLu2rCG5nTschEOEZwrNsZ92
         Va+BIZaxWRTp2qm4+IGspSwGrmM9huuOkpaoY2H4V9lRtcUoe0Qt1P/8nguq6zMt7ish
         iLQdsM0RSmX1cNgKTqGER6gRJvKb8Gvaybkr2/iD7Wpw96+f22iLHB+sW79LekjH1zTH
         E5avlCYBEzXz8bXT57drng1zmKu1Ti0ibiA7xYwBXMqVGqNP41ndNKHL3W7La+OOQ9dn
         w40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963146; x=1761567946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joBbZlAKq9MKYKqmzAoAqjZljgU+WlqDqzpRmSnyPTc=;
        b=qcUGZ0MmUL8HurzCy7gVtqtCa4kwIpmjtolmcyWTDEbfPHDbFkK3IU35cuQidCYZgT
         U4nNFu+55ta/PASthfnAAbFrX2m/8MqOgOtn0vuGHnfzueImgPlH36CFsbrnc/LfGnmG
         ybbkLalGyBXpwO95U6WCZVOCrLHjv6eMYj7oBdi9ZqqcJ06L5Ue0luFcfnjDJSRL9iPZ
         jgRUXwgxbO9q//N/TuZWfNQ0yjLlzqeSpk8Hh5OoQ65B67bvZ0nEN+7bpVArlf6tkO9y
         zD1xfghnRioptWgEKgSotJuIcNqSPv3kDk5Cet4EitBMie0eJ+3+DUYjDchiwFRHM51T
         b3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSeuVPzmbY2Y5RXP1kPT+Id/MJF8fkF2i5/y95ry+mdSQkLOFqNQFO+MJvqVQgAA36VQcdg09D9ERoRBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA68SRpAy4WOCKqoCDAJj/OlaiS+WWgw4Mn9rFCPKtPIFFgVJ4
	tzIBwhju+S1iFVWhyU+p/07/ZFJev4byCIU9fUb8lMexNLx2E1cZrKpJuR5NBpRH3yk=
X-Gm-Gg: ASbGncsPWRFy8CxRKs/s4iYBb5fDLnHAZL1ni/k8BF7i0yMLlXM4gRztWu6IGkGMWJB
	6T9sDRoWA25HtbizOBmUArzFGlediEwHLDrnOrjbqZrWgm8e/3nNxUJb5npPha/t0uRVDsnC99U
	RpyYAbH/sZmpiQZjs6zexyna/fj5bjslZX/+FisBT+m2SesXtD79eUHJNjYbm4/nYoco8miRUrr
	Xu2YTjuWO9AEl/Coag280kAvHGdEP+NoAoAr/bm3A9kdkTtjxNYnjkRbqvK5p2llgA8/Lv4+y43
	nfBXKl72GD1k1HjY2verw92+y/50ag83IoX93E7jDXHoQfgCH4bEm1mRLZvwfwF8kRfu1c3mT0X
	d1ENumOhzoyYvVv/BdAKkk28u7yO0yrovAfRTBus2qtQ7YMs5pJggTe+rw0egHY9nSs8A3YogEG
	A53ETJJTjlH21gYyc=
X-Google-Smtp-Source: AGHT+IGE/91ndXqrZPeGjmvqLfbZ828jO+fUoAyw/TzeN2763Thm39KbDzwmTzVAkzPrvwfG8tgRPg==
X-Received: by 2002:a05:6000:2087:b0:427:921:8985 with SMTP id ffacd0b85a97d-42709218a51mr6985887f8f.40.1760963145881;
        Mon, 20 Oct 2025 05:25:45 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00b985esm15662696f8f.34.2025.10.20.05.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 05:25:45 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:25:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] netrom: Prevent race conditions between multiple add
 route
Message-ID: <aPYqRJXGhCNws4d3@stanley.mountain>
References: <aPYKgFTIroUhJAJA@stanley.mountain>
 <20251020110244.3200311-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020110244.3200311-1-lizhi.xu@windriver.com>

On Mon, Oct 20, 2025 at 07:02:44PM +0800, Lizhi Xu wrote:
> The root cause of the problem is that multiple different tasks initiate
> NETROM_NODE commands to add new routes, there is no lock between them to
> protect the same nr_neigh.
> Task0 may add the nr_neigh.refcount value of 1 on Task1 to routes[2].
> 
> When Task2 executes nr_neigh_put(nr_node->routes[2].neighbour), it will
> release the neighbour because its refcount value is 1.
> 
> In this case, the following situation causes a UAF:
> 
> Task0					Task1						Task2
> =====					=====						=====
> nr_add_node()
> nr_neigh_get_dev()			nr_add_node()
> 					nr_node_lock()
> 					nr_node->routes[2].neighbour->count--
> 					nr_neigh_put(nr_node->routes[2].neighbour);
> 					nr_remove_neigh(nr_node->routes[2].neighbour)
> 					nr_node_unlock()
> nr_node_lock()
> nr_node->routes[2].neighbour = nr_neigh
> nr_neigh_hold(nr_neigh);								nr_add_node()
> 											nr_neigh_put()
> 
> The solution to the problem is to use a lock to synchronize each add a route
> to node.

This chart is still not right.  Let me add line numbers to your chart:

netrom/nr_route.c
   214          nr_node_lock(nr_node);
   215  
   216          if (quality != 0)
   217                  strscpy(nr_node->mnemonic, mnemonic);
   218  
   219          for (found = 0, i = 0; i < nr_node->count; i++) {
   220                  if (nr_node->routes[i].neighbour == nr_neigh) {
   221                          nr_node->routes[i].quality   = quality;
   222                          nr_node->routes[i].obs_count = obs_count;
   223                          found = 1;
   224                          break;
   225                  }
   226          }
   227  
   228          if (!found) {
   229                  /* We have space at the bottom, slot it in */
   230                  if (nr_node->count < 3) {
   231                          nr_node->routes[2] = nr_node->routes[1];
   232                          nr_node->routes[1] = nr_node->routes[0];
   233  
   234                          nr_node->routes[0].quality   = quality;
   235                          nr_node->routes[0].obs_count = obs_count;
   236                          nr_node->routes[0].neighbour = nr_neigh;
   237  
   238                          nr_node->which++;
   239                          nr_node->count++;
   240                          nr_neigh_hold(nr_neigh);
   241                          nr_neigh->count++;
   242                  } else {
   243                          /* It must be better than the worst */
   244                          if (quality > nr_node->routes[2].quality) {
   245                                  nr_node->routes[2].neighbour->count--;
   246                                  nr_neigh_put(nr_node->routes[2].neighbour);
   247  
   248                                  if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
   249                                          nr_remove_neigh(nr_node->routes[2].neighbour);
   250  
   251                                  nr_node->routes[2].quality   = quality;
   252                                  nr_node->routes[2].obs_count = obs_count;
   253                                  nr_node->routes[2].neighbour = nr_neigh;
   254  
   255                                  nr_neigh_hold(nr_neigh);
   256                                  nr_neigh->count++;
   257                          }
   258                  }
   259          }


Task0					Task1						Task2
=====					=====						=====
[97] nr_add_node()
[113] nr_neigh_get_dev()		[97] nr_add_node()
					[214] nr_node_lock()
					[245] nr_node->routes[2].neighbour->count--
					[246] nr_neigh_put(nr_node->routes[2].neighbour);
					[248] nr_remove_neigh(nr_node->routes[2].neighbour)
					[283] nr_node_unlock()
[214] nr_node_lock()
[253] nr_node->routes[2].neighbour = nr_neigh
[254] nr_neigh_hold(nr_neigh);								[97] nr_add_node()
											[XXX] nr_neigh_put()
                                                                                        ^^^^^^^^^^^^^^^^^^^^

These charts are supposed to be chronological so [XXX] is wrong because the
use after free happens on line [248].  Do we really need three threads to
make this race work?

> 
> syzbot reported:
> BUG: KASAN: slab-use-after-free in nr_add_node+0x25db/0x2c00 net/netrom/nr_route.c:248
                                                                                     ^^^

> Read of size 4 at addr ffff888051e6e9b0 by task syz.1.2539/8741

I'm sure you tested your patch and that it fixes the bug, but I just
wonder if it's the best possible fix?

regards,
dan carpenter



