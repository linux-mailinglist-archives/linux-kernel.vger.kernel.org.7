Return-Path: <linux-kernel+bounces-820248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED0B7CF39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A6D189F2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A133016F6;
	Wed, 17 Sep 2025 08:36:16 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584B82FFF8D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098175; cv=none; b=BSKcoTWpFE5vYJ1dSRPiIrXE8DIV0fYT/rhNv9s7/GKLFtUutQ27WmuAvlBOL6SEd67PQho2I2vGHIucsl5NAcweRBH67MyNQbmbayHQ836FxJXQ1ECt4H1L3pTGnNZmCIFoyaeQei4yZ6pA9iT0B0fuXm4sTzmmm7e6pw/4j8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098175; c=relaxed/simple;
	bh=sXFkn3fuD3qapzhmeLtcjyz5+yB2lVkMKUy/xANyteE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBdc+Ro6MduLmr0us0l3V6B95b/0eAYGF4YUn89n3e7PHQ+bV43mnKiXGiSTW3/vtaWtS3EVA7o1z3PA2cpF9/BRYXW2sPQ7x6Jof1RNMY7kNkVUSsMV9WPz6qR+Zk6+ZGhr0mVWj3mTpLb4WgpZ39tUON911dZV9Mkfc/+mdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32e1c68d806so2796227a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758098173; x=1758702973;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5C6ubQVztzzRmQnjXOEGDILcUWZK/yh+JDrJ9NOH2l8=;
        b=DQo9SxtaR4hZHON6JTBwgAZ28c6EwUpwMPrynWfUdc103I0WFa6TGlkQGn91s1jRhh
         xRXeiUv6nCj3b6wUiKvlJWAmHQ7925t3sHuEijS0jBMVqA4R4ovofh3djH11REhKxPin
         HxwYa7A9AzAGpdNmfFhimo5eIZ/mTEeyxvcmjt7jZKcf1d5QZzRnfkMItq1ugoOImqAD
         ynAnb2bZobiqXmQc6FOVTlgzhDzMruEmJlbsLmRIII+wJmQDB6YWUeCtyiC1Llq05Xbf
         8dQ+qk6kA3WY/l3D90+m2+B4lTcbad8a/L1VU38htDL7o2MSJPREUUfJfhBUNRGALY4L
         dodA==
X-Forwarded-Encrypted: i=1; AJvYcCVxZSpyn74qW/ufdAC/g3dTQ3lwWeCTwNebkP87UBASDy1ISFnJYrZ3eFTTgdn0/7CHvKD9/RwocwfyFMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeoGwhTr5PKa9PwOyDASecob4PBAbDn5R5gd8ZopGy3A1WNDvS
	9ABr1gFa2joaa41Krd/jT3VvDyv7ilGcLh92uA0tnA8FOkGbXRH/47Un
X-Gm-Gg: ASbGncu4/MuO6X5vgDNIJd98TjMPyRl8pQYTRz955Qpz2120HsdAMV7EJvo7PtrnV00
	ec8xp2khW2DQkmyQjKVg4H3kg7Am0fda7N7gE95pAF3YjxGKKv51w3mCeoOWmkLS7W5UB9YausO
	iSBKhTByJs3s4kPOf9CNylCRs12N2PYcMjoaB3d2HsHDUvUZNJW3QY8pwZ6x/rryXyu+iEA9r0x
	/ZhIMFl2Zpr4wC2F4QPSgZqgqSOGB1M068tF1xWec0QqUTHLa9Urm4G45t02eSfh3yUySXhPkOB
	VHKOyxVtJhNZC5n52ixRsOVS1cfGdbRqvHyAqo3NUWLXrnmMsu6XnvDk9oCzqE+0wpaMreFLGRd
	E9Sw4gV0ViVhevkkkuFAJ1bJzR/J8KwhDSjTEQzn/OJiVFUBKawVl+qFtsw==
X-Google-Smtp-Source: AGHT+IHADwAA9JCqd2quqoOP3FocyxM/8owwIIVqvZ9oow3gcrEgcb/6VhdirEK4z8X/BFS9knXdhA==
X-Received: by 2002:a17:90a:d88b:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-32ee3f7b4c2mr1574450a91.26.1758098173401;
        Wed, 17 Sep 2025 01:36:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32ed27612b3sm1764647a91.22.2025.09.17.01.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:36:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 17:36:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250917083611.GB1467593@rocinante>
References: <20250821232239.599523-2-thepacketgeek@gmail.com>
 <20250915193904.GA1756590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915193904.GA1756590@bhelgaas>

> > Add a single sysfs read-only interface for reading PCIe device serial
> > numbers from userspace in a programmatic way. This device attribute
> > uses the same hexadecimal 1-byte dashed formatting as lspci serial number
> > capability output. If a device doesn't support the serial number
> > capability, the serial_number sysfs attribute will not be visible.
> > 
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> > Reviewed-by: Mario Limonciello <superm1@kernel.org>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Sorry for the delay, I have no excuse.

I also didn't noticed it has been a while... This series has fallen through
the cracks completely, indeed.  Sorry about this.

Thank you,

	Krzysztof

