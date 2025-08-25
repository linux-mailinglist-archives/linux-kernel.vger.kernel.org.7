Return-Path: <linux-kernel+bounces-784276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25133B33940
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E01E94E28E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689ED2C3254;
	Mon, 25 Aug 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5PcyLFd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CD29E0F7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110757; cv=none; b=HwoN8aXIgW9leL6T7vJLNX7G7GnsAZfFgt53abEu6xAHu4K0la6fsZ5N2t7WCtQMv0lAI8GnGjERnh5uCxvdLdT0imObd7OH3jtbzXX1LDKwGaycS3Oin0WbrPw3xxKgSQDaVtEtyARszTsfzfm1v9dekEbQWH5ZSJXdHBusVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110757; c=relaxed/simple;
	bh=rfec86x6qpS2GWOHd8CZpyIL1gmfTj22kaCmEkmBLbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEX1sXLECPnAEkQXi65jegdwo30Mv3ujKIMIBz+MJOKBEElCYw7YyJt0tDglImfA4aTlYQT/vH7SWbxVLhSYVPRO07TxvZH9Bo27AJHe3JuD7bg5Xji9qbeBcqDf0NFvb153ihl2Mj+pkbfY/kTQuJPwH9n1zLKM2XHthCnQT+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L5PcyLFd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756110754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+Kd1Ty6UgWWPnKhsbBAczdSxHzDVOW+iGIrAJcYqpEg=;
	b=L5PcyLFdshLZDrzSGPxoYL8XvmREBrWj/vWpG4t189ZuM0P2G37F2/JMBtNGdeQbIXUkkX
	xAvLylboRc1C7uue2jMgdqwhYluo9PJ0vrFjiehkdt0ANGq1/5WLBCNpwkz4bpFujY0rH9
	hDoeuswxExDJrKGrEM7NjszUnkVhv+s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-p_3A2s_xNYOySWDPTUVu6Q-1; Mon, 25 Aug 2025 04:32:32 -0400
X-MC-Unique: p_3A2s_xNYOySWDPTUVu6Q-1
X-Mimecast-MFC-AGG-ID: p_3A2s_xNYOySWDPTUVu6Q_1756110752
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70da94b2895so56016256d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756110751; x=1756715551;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Kd1Ty6UgWWPnKhsbBAczdSxHzDVOW+iGIrAJcYqpEg=;
        b=ZgyhyJH1jxp6Pu08QEoMr+C91uRjD5emKXxQMvHBoW4lE4XESZUjqt0wuno8hEP0BP
         h0LKnPCefHtKP1kOUMejCn/8xoNGEZZV3TwRuJXKswvxqTjv2AE8HeuplaE6rqaXsd6T
         DW1LPz3WGJApg1KrWyHklS3cfsmg70XiI8vGB38QmrvcBOOAJ5vSYS+VOjXXKeBXa4NU
         Ie8jVEGnC5QJLdsOGYsLL8MMRTG9jpSW6eoOso7nEDbbGOgtC6vPaNm2xqVOvVLCgIB1
         05FIfciZvoPsh+iKY+Q6ZxjV1amvBXHVEPvClAdQ410xWyeVIAXtPlrUjpOa9mM0IoHD
         BBdw==
X-Gm-Message-State: AOJu0YyQLfzbQSBB+OZhE5N1Hqfg3wfOxbmae/h0ms8IZoSnfYwcHAkq
	L/RwvgGfEgYVfP84w6uWYMCM2OaAprD70iOfLusVVZEz/tgmzuJUBtTD+Ui3aF+PmkTtv6GyinN
	Elx1x6CwRBoRqRsE4PKww80e0B6mlGJZ4Y78DXhSD3Jin9+k+CR3A+Inz7dVc1R3gt+RyViUhx2
	+i
X-Gm-Gg: ASbGnct1xLwI3fyW0cJBl7xJ/0MWRg4uN/A8+7V0vwn6aix1tEroUE/u3TBP9u1yPA6
	cDUwFSVKgEWeugXC8rppH5obovu0ijo/eWzr2UIacIQ4CURL+37hKv3H6qXA/TVHwcbgL3rvDP8
	3lJtsgAPFqaZd7a/f8L8x/4kUBNF6ustwiXVuJqolXw52RhthoG8QhzV66SVJO0dc0d0lJakfaG
	P3Bj8LZiYPvRTuWgZ4QrzT360L47gU0/MXvMLkD7ZpBJBJq9dXn4RCPY9yDENh2L8fY7aKqFtZw
	ysyhph+ah1e8BOq4GjgTOx1+vXNHG0ESsAMdMzein5hy33nR7BaPgauzx3WYDO7bRg==
X-Received: by 2002:ad4:4eae:0:b0:70d:8ad0:93d5 with SMTP id 6a1803df08f44-70d9710e96cmr109097966d6.20.1756110751621;
        Mon, 25 Aug 2025 01:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb+juQwMAs0Z188vrqiQCNcrXZ6PhDrXohg/HAYXKHBZaqXTkAZv+abGTymzbx1a2+rydpQw==
X-Received: by 2002:ad4:4eae:0:b0:70d:8ad0:93d5 with SMTP id 6a1803df08f44-70d9710e96cmr109097836d6.20.1756110751290;
        Mon, 25 Aug 2025 01:32:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72aff63sm41947316d6.51.2025.08.25.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:32:31 -0700 (PDT)
Message-ID: <62b076b8837139eb109c3958d28318b0ec508344.camel@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 25 Aug 2025 10:32:27 +0200
In-Reply-To: <20250825081320.syZmsSiH@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-9-gmonaco@redhat.com>
	 <20250821121846.N0S9tb6x@linutronix.de>
	 <fd9dc21acd4fac68a3948ded59cf9235f0e4bb7f.camel@redhat.com>
	 <20250825081320.syZmsSiH@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Mon, 2025-08-25 at 10:13 +0200, Nam Cao wrote:
> On Mon, Aug 25, 2025 at 09:48:23AM +0200, Gabriele Monaco wrote:
> > On Thu, 2025-08-21 at 14:18 +0200, Nam Cao wrote:
> > > On Thu, Aug 14, 2025 at 05:08:00PM +0200, Gabriele Monaco wrote:
> > > > Deterministic automata define which events are allowed in every
> > > > state,
> > > > but cannot define more sophisticated constraint taking into
> > > > account
> > > > the
> > > > system's environment (e.g. time or other states not producing
> > > > events).
> > > >=20
> > > > Add the Hybrid Automata monitor type as an extension of
> > > > Deterministic
> > > > automata where each state transition is validating a constraint
> > > > on
> > > > a finite number of environment variables.
> > > > Hybrid automata can be used to implement timed automata, where
> > > > the
> > > > environment variables are clocks.
> > > >=20
> > > > Also implement the necessary functionality to handle clock
> > > > constraints (ns or jiffy granularity) on state and events.
> > > >=20
> > > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > >=20
> > > So you have figured out how to deal with the time problem. Cool!
> > >=20
> > > I'm curious, instead of a new monitor type, would the entire
> > > thing be
> > > simpler if these new features are added as extension to DA
> > > monitor
> > > instead?
> > >=20
> > > The existing "pure DA" monitors would just not use the constraint
> > > and
> > > timer stuffs and would behave same as before.
> > >=20
> > > Just an idea, I'm not sure how it would look like. But I think we
> > > might reduce some line count.
> >=20
> > Mmh, that might save some lines, especially the *_hooks() macros.
> > The few functions that are now duplicated would end up together
> > with a
> > condition, though.
> >=20
> > I'm however not too fond of forcing any DA user to allocate space
> > for a
> > timer. Imagine a custom kernel for an embedded device trying to
> > squeeze
> > some RV monitors in tasks and ending up requiring 64 bytes per
> > monitor
> > instead of 8.
>=20
> I'm not sure if I follow. We put "union rv_task_monitor" in
> task_struct, so
> we always require 64 bytes, regardless of the monitor type?

That's right, but if no HA monitor is compiled in, struct ha_monitor is
empty, so  union rv_task_monitor is as large as DA/LTL.

> #ifdef CONFIG_RV_HA_MONITOR
>=20
> struct ha_monitor {
> 	struct da_monitor da_mon;
> 	u64 env_store[MAX_HA_ENV_LEN];
> 	struct hrtimer timer;
> };
>=20
> #else
>=20
> struct ha_monitor { };
>=20
> #endif /* CONFIG_RV_HA_MONITOR */

That's why I wanted also LTL to be optionally empty, technically we
could do the same for DA but since it's the smallest it's rather
pointless.

Thanks,
Gabriele


