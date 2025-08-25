Return-Path: <linux-kernel+bounces-784231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366EB33869
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BE18951E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F5328CF5F;
	Mon, 25 Aug 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCyg9tsh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401B28F1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108964; cv=none; b=Q5fy0+KjWIq9GOaC1LCrNtjGpQCupF1xd1XI6bH/nEc23VeNr5A60iu9ZCKpmBw/E2RkbokaacokUaRASi9INLcTiLMjce9jN+GP3j+VEIZhCoFn5y4p+i+ae41pXsv8J+UeQudWE0WY57PyKxDJZ+0lrpOBkw9kP83IFzbu7jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108964; c=relaxed/simple;
	bh=jtj32Xw/Bw9jPEykvUodU7gwzREkOnoEEFI1mSxg0to=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pruONK1aqpM6QVv8hYd8geRHpEuJq8lO0TG0h6/kSdNyopUFXXnsBn6xXFs4h3vlKn7+SLy8REFPG0kbMMRDc5/whPxtMdJn5l2FKDz0XrJd7D8mCuk/xlF0TkiYxC2fzXqSgaKU0H2YRkdAGd7hYf+MUe6p2xcatL6hIJp/7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCyg9tsh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756108961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=swYiZ2KuheWlNy62lEXuye07ubCnuW3AXIo+P+pAkUQ=;
	b=MCyg9tshA++Oo3wOXqbLVUMCrkesVXn3JiOTpPwgWnzkj0eETZDaahQgkvRS7HnuxEyxGx
	w+zD6G3oUfryzVp9uROCWGrb2PYgsBrP0SfVzdSBILtAaPa51Gb4OMlNcEPApGggLgdwgI
	g4cFqdXZv89vWziAWruwM3tOyj8EJAg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-yXVPUzxGNf6fzF5GmU6pOQ-1; Mon, 25 Aug 2025 04:02:38 -0400
X-MC-Unique: yXVPUzxGNf6fzF5GmU6pOQ-1
X-Mimecast-MFC-AGG-ID: yXVPUzxGNf6fzF5GmU6pOQ_1756108958
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70db892e7b2so20270016d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756108958; x=1756713758;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swYiZ2KuheWlNy62lEXuye07ubCnuW3AXIo+P+pAkUQ=;
        b=EdH+WamsQH6s1J6JQCI2nzz7gJrcGZM4K+MGk8wRUYyleQylbxAu0He4E8p8MoTgSM
         DKLb5SnNCQA/oBLIkD74PUanQHlHbttjE7oPkxVvNxXbD/kkl0TVkiIRnHLdz1knPSke
         BNSsVjMaa8kP0oDYP6nBqystWkHFaUArdYYDByi0b2rhm0TspRsq9l/sUg3v+7rv9rlg
         Nb2URjwnckrkTptpt9WMfzpAcpl72nbkNBYWKdDiFu+fqTzkvLhLnF0tiDAOlBbRkcb0
         6kKGXloCgX2h4qksaW6icVoyBMS/uGG8ctAjByqUrB4U+tn4n6qKbIDQ8l+4LfjUF70u
         GJjg==
X-Gm-Message-State: AOJu0Yww8k4ekpQ3eWCQTvW8aTZ28yZvVoOuaAQDWmsA6os+pYubkzPS
	LLs8oDDNRcL1/HJWNMA5E8/RWNMwZHmPzwTtegvtVp5bEFfvmgYTWJOqgdyWnuStOqnVmAdcbwB
	48z666F/bFL0N9iHfs0Ooe2TCMMwmrL5vi1nJG8PHa/oHdUeEyVk5z3rCDYsydYUbaQ==
X-Gm-Gg: ASbGncu+uiYtZtiI1WEAi/sVgwI40eO5ECO8tyM8libFJGhq6yW5qkZlStC1V1tQyyM
	yjPAdnCaV0kxIAfIxwFzA4UmqRqPzU117J3inS19wZVsqTXKGEEEGdo59aK9KW7dOlHfPzg3bH4
	fqe9Loh2Luxm/5dcpKsGYciTydh2fCz4PMQ65hpJfCIQsZrrfgaY8AslHv0mXj0hDYqM6Byuloa
	HdQ/gTugk1Qzua+UauH8UIcyEpelWKMy+DGF3SB+DO0Cq0U4ieSaE3H4AR7YcQdXkeL4kukVtH4
	51opnY542NYbkPLUWDKWdhFwsrsh7ZF7Ot5YaWcMDonfhKS5oaYpo8A3o+c5dIlzxQ==
X-Received: by 2002:ad4:5c89:0:b0:709:edde:53cb with SMTP id 6a1803df08f44-70d97097766mr121861276d6.1.1756108957921;
        Mon, 25 Aug 2025 01:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu61qI2y1NfXoRCal+kkQuMJpjsJ6CjTOn/WkZ07F8a4sJKCIPxEExtscCdby/+v2hXxZxJw==
X-Received: by 2002:ad4:5c89:0:b0:709:edde:53cb with SMTP id 6a1803df08f44-70d97097766mr121860836d6.1.1756108957360;
        Mon, 25 Aug 2025 01:02:37 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72ed68csm41461496d6.75.2025.08.25.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:02:37 -0700 (PDT)
Message-ID: <5e122c0ed80fb57223f4630d0d83186a110bf056.camel@redhat.com>
Subject: Re: [RFC PATCH 01/17] rv: Refactor da_monitor to minimise macros
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 25 Aug 2025 10:02:33 +0200
In-Reply-To: <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
		 <20250814150809.140739-2-gmonaco@redhat.com>
		 <20250821081405.RQhrWVKp@linutronix.de>
	 <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>
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

On Thu, 2025-08-21 at 10:49 +0200, Gabriele Monaco wrote:
> On Thu, 2025-08-21 at 10:14 +0200, Nam Cao wrote:
>=20
> > > +#define RV_AUTOMATON_NAME CONCATENATE(automaton_, MONITOR_NAME)
> > > +#define EVENT_MAX CONCATENATE(event_max_, MONITOR_NAME)
> > > +#define STATE_MAX CONCATENATE(state_max_, MONITOR_NAME)
> > > +#define events CONCATENATE(events_, MONITOR_NAME)
> > > +#define states CONCATENATE(states_, MONITOR_NAME)
> >=20
> > I think these macros make it harder to read the code. E.g. it is
> > not obvious what is "events" in "enum events event".
> >=20
> > How about renaming these to be the same for all monitors, and get
> > rid of these 4 macros?
> >=20
> > Something like
> >=20
> > 	enum states_wip -> enum da_states
> > 	state_max_wip=C2=A0=C2=A0 -> da_state_max
> > 	etc
> >=20
> > Just my preference, of course. You probably have your reasons for
> > doing it this way?

I had more thoughts on this and I guess at least these enums might need
to stay as they are.

I'm working on a patch to write some sort of unit test for monitors,
where I inject events and see that the errors are triggered.
For readability that requires the events definitions and, currently,
I'm putting all those tests in the same file. It looks simpler to keep
the enums different.

But of course any suggestion is welcome.
Thanks,
Gabriele


