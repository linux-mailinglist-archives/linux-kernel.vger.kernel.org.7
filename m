Return-Path: <linux-kernel+bounces-861105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1F0BF1CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CE73A9F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC231986F;
	Mon, 20 Oct 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HLRQmwV3"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC62ED872
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969954; cv=none; b=ezpTQcyBxhb64wkwpCshMvohXPBCcqW1TDtb1s5twaT3QVNUUBdI4IG17bAIlw2fLpTnztKpKx6dC7aO3Z8LeVbstb3TlXjxRy19nTgmsjKMtPUvZr/foQOdVkOcliIoinbJ/fB5G4CBWAnYK5GVIH7BWtarX9B6HlApyaP9VLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969954; c=relaxed/simple;
	bh=2npudKn3M3pGuvcNhStzzobNKAnWlVCYEMk+IX+Cn00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhtvg8C2YdsBDKbJvFw7qs2Ep76Pdpjdt+UCBEDoCKnYsQHgtQrsrjGKGiB9Sq/0kChOmCvB6Ld80ljed6WwhlL0Dgbgp6GApGp1g2Htg2NOr7WjFsTRVtvE7zMeVlKWYn6eyAWfwzMwiGCG/sHGbsAMTYSjxtfNZyIc13sHWx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HLRQmwV3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8901a7d171bso553504885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760969951; x=1761574751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+qpyUIh0Tk7malHtrxqPktm9KOxI8snDhlaveespDlU=;
        b=HLRQmwV3ChxvDcup/Z2+kAXm2ea9QBwL3R3+TcXkrOk7+FGDaTGQaK0OhpVt3opVWC
         4jX3i5tVr3ObVn3s9AmgUE/fbwOj17wuWTvzpe+/WfNM+ZfypXURbLDpphy6U2qOyQL7
         itjHOXZFnHnkuAcEaPHT9oY87gQJ1U9Vuc5q6NlJROIKPrbLQrE8hTLwuLAl6wp5+r0u
         dwSV7PUL3js/7aHgWGcXvzxscfkh+L50DqgCJiYRWpHjtY1JdIiHq6CSbR20OR15bja4
         uZP9ej1+oTMJrjmPiV/8Y4YJMhfvjDyXz5go9H19XCtvm0JjNDuK0/76Q96C4j1kJxxl
         ATBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969951; x=1761574751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qpyUIh0Tk7malHtrxqPktm9KOxI8snDhlaveespDlU=;
        b=AWSwkzsr/3HDokiXOwIaDm0oHkauPNeC10B9rB8pu6a+u5rg1+nPPeXDG03bv8bUEv
         xtYtBXwk4n80bAIL475ObiHnCZTD4pLX/PXvScnhZkxbE07ZXBCoHOApLSuHNrG1lldu
         G3QDljaAsl48IEfij6QOsZo76D+8/xfHQvJV3aTqvtXjrwFQiTXkzhN1S2fIrduOXT69
         IgefkqPporyVd9gR+0GlaGSgXaFb9NOFnKFy1wckWDu7VCMR1VqDMKmPvHjcSun9ehtB
         lqCTwFxxX52DUHaqByW43Gl7q04srNXhwIe9PZzIyGrHAKupuHFFiPDl95t2efZ9Ec4O
         n1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmxv5ADVVb3TUW9L9xNlcfykbje8G4KfPD7N/82HrILMG/dKsYdqllZbTEcuolMYLyPTCr9KjO7JZqWeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfgyqx5423YcLvGfaVUJPOZSOp5+IFDPcWZcO3f7yUXzskhPMq
	HKwHk0ZtfaMI5VlFdHfay0dicnZEU6mggk3cX1AzCJOkH7WMj7SJk8OtcRb5neHYAFc=
X-Gm-Gg: ASbGncu+H4QdBh/3AaZZAa3H+Jqjz9kSFc9n9y6HJOp5qBcDqdBYD0qoOApeIrkg2Nf
	4reN7LqCddqnXMZjxZUaeELnCccbMK5iOwNybmPphoP1fvbqvEZPLlYpuvxICYWwbqHXk/+bzfr
	O/EQ4VMbx1NE67uo2mguMkVRu5hYSFo8JTTc/c19Hv+odmUy24ul1KjYtkwW5XYhG2gBEezr3vc
	njSTXJg9DdQnQsEBC8Tsckf4v8E6A4Qh7JfUnNfuV4/aECmNzarvAvGbtfg0YqGC7K3sVaXaXSf
	f6B2xhN8tsM8yskZRZdg2019Xu+gJ3c/bAJuC7bJmZ9gb5hy6fyTX9S183VOG4577lEb/QUgoWB
	ORyzJiy/VavHNAj4ohxPpf9fjhWHeYop/Du+Z2AYbG/bEvr0sjocHhko0ol+bvEdYGv4dNcjbVu
	qOxfh0imddEGs4GDZUmqcnaYI3+J/pVrwJIJnUz8T3oIxuF7zi5iugxPziCd4GJ6RRTfKU7Q==
X-Google-Smtp-Source: AGHT+IHRCRqY4YjVP7KDo2gTi6tLoUYXho+CWMkf+1VAhi9o3M4Tof/3oq0+LXyeXxZiWLuh71yZog==
X-Received: by 2002:a05:620a:40c1:b0:891:6891:5668 with SMTP id af79cd13be357-891689161b5mr1432264685a.63.1760969951455;
        Mon, 20 Oct 2025 07:19:11 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58eec0sm565840285a.45.2025.10.20.07.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:19:11 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:19:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>

On Mon, Oct 20, 2025 at 12:09:34AM -0700, Alison Schofield wrote:
> > This patch updates cxl_test to enable decoders 1 and 2
> > in the host-bridge 0 port, in a switch uport under hb0,
> > and the endpoints ports with size zero simulating
> > committed zero sized decoders.
> 
> Decoders 1 & 2 - those are after decoder 0, the autoregion.
> That's a problem ATM, when we try to teardown the autoregion we
> get out of order resets. Like I asked in the other patch, if there
> are rules about where these zero size decoders may appear, that
> may make the solution here simpler.
> 

I think this is going to require a quirk-doc like other deviations.

A committed decoder must have a base address, and with 0-size subsequent
or previous decoders would also have an address that covers that address
as well.  This is on top of the ordering issue if the 0-side decoders
come after a programmable decoder.

I'm not convinced this even makes sense as a security thing if you can
reset the bus and re-activate everything (after a graceful teardown).

Seems easier to just report the decoders as unavailable and then not
probe them.

~Gregory

