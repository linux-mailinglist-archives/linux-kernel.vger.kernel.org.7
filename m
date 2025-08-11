Return-Path: <linux-kernel+bounces-763196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE0BB211A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15FA6E045B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF10A311C2C;
	Mon, 11 Aug 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WqrYrx2V"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBC311C02
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928655; cv=none; b=pQMJ+ZYaNbz3j66OdZE1WJAUb1av/hQTUtlq8I+9pyEUnpzw7vCIHwzgOHOsXj6O650aiqgtZcf1L5zWmeM+qoaYK1XA+b6qUlPda1Zyzp3vPBAzlnhV5n07uivdeBCqIUbZBXVpp1+oVbqGq/D6uR39PjRMsh2QmXd+PHRMkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928655; c=relaxed/simple;
	bh=2iQ+zP8IZgZjmzdsrNembThxpAvNcdLs7/zu2LZbl4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhASQG3FVvaa2uTtrJHkovzcznZoSz7w9TJmVrAeoBqKL1xtA4LAPVGJNPhAb8LI+gi7lEEITgwakhKX9Bv2d9UGMBSOges0APOtgY1X+9sZ9Rf6GGRaSsFSoRepr8wfc79I2eZ6ixEsX+AKshETUxP6CiSxJg7WK3ge4ncWm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WqrYrx2V; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7de159778d4so476280785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1754928652; x=1755533452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I0vihZvzkYja05da8lt/tsUAEN6GCqwoj0EGOu1+LDI=;
        b=WqrYrx2V9ZUdoxbQTf8aHkRiAV3GRdx2nxencVEf9QoBAyqwW6+Ebjc5OfjVWnBz/O
         hWZ9qyq3ZhcH+Gvp+2UA7r+7qiwN7SSfaYHhyTmI0C0SjWG77zkOfUuJe6MOtyED6MPz
         Pln9tsZXKi7vkyGZ/Tp1kosTs6VJnwjCKPUp+DGRUXzZ98ALAuIxhOecsUSBgpx6ofRb
         bxnI+HS7qX5xs2h4pu7SevLiHHHqAiNcKNrD3KjLW6Xg6ElK+1Lz1CtU/5+gRuWSNcoF
         2hknUGRh4jsCU+zw+66xEmWRFvKx9UHhA5LDzgllOCNyX9iLdih2VtfnC9r1jYCfABRP
         6hIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928652; x=1755533452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0vihZvzkYja05da8lt/tsUAEN6GCqwoj0EGOu1+LDI=;
        b=ZmAG9+y8KmOZeTSuV1p21s5oRs9OqwUD4emkcgQ+QgYsT0rf7l9OcMAe7GJHPWGpeV
         61kV1saAhGJTW5MvC+qc9rLQh5RWg4quv3R6tek9clbVSZ/EIvZpo+LnTOExp8gxpHfL
         MGcWtK+KjwQ43ZjX110Ej4CnYc2qTcTf4Ox4EJY9NogcrOvFUAxPS6yIKqxoE6EKxeo5
         4rjna6EpG4o6zrvDFEaqYeb+0oktcy/GXK88tzzKHniWcs3GiQs+NF7e5aNbe9HxEcIu
         Ebz1ZsaJXHHRpzGNXN8ghYi5bcbk0Og7IkQH8D+E7pT762EpORJ1wnzpObp441pWajvd
         aPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNV90GOfr3nysWhI/lMPBH6B4oTk5HAoATdad7XavS0lrgzTNolUo956dRkM4dlJXbOWPcD+tb5d19FZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xwxDs4PTTI5YEIVTbC5JVRhi6QjpYUA7B0vVVu4IIm3jMT1N
	2Ew4oU3nlSKwNYPrBuz7JTZ1XDS/pvxnw6BMj7G8+Z75d5qkqeippDBKxbPAvGkARw==
X-Gm-Gg: ASbGncuoAVCCT8zd+wPQlUBWn+Ix8AmpnE1qOSw8ypFnIPdZbxXqkKsfQ6Lq04hcgzI
	R+neM9LsKVNy/zYO2daDNIi8A//V8hjJ95mvj3aBP4LPdkyT4k1LC7CdDzjLk9exczeg8TJYcZi
	G1jq7ubE/2LQxCOfBa8y17IQ09N1reJj3JgAY9r9XMC56zJZJoWm4KfzpZapLacnHA+IJjaWHg0
	rLGf/oZNx1c1wwoOBdO1s+gewT1NcI1b7y0pqT7puurLsOw30epxDux2iCZoFo41nyJmqEvGa9I
	CIlOJwMlHnTZxOnNfXiSryiLFxEpqAPXDIjDy9TSgNRVnd6t89Rz42+aj/e8RB6mkSe5HFhD92b
	AuG/5z00qoMaEvKbOxyquaHnl8oVuNDvPQsxcx7AgaCDy70fjbZTG9JPGwUMSCTpfoA==
X-Google-Smtp-Source: AGHT+IEMGn3UNVRv56EfsR1Myj638KVPOu0DkYeFN3iH1PqDN6k0dHdqL9RYiTb1QZnURjFYoBIiHQ==
X-Received: by 2002:a05:620a:f13:b0:7e8:9f7:da5d with SMTP id af79cd13be357-7e82c61539bmr1956421885a.12.1754928652374;
        Mon, 11 Aug 2025 09:10:52 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:349c:f507:d5eb:5d9e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e82a12ebf4sm633387085a.54.2025.08.11.09.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:10:51 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:10:49 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Chary Chennoju, Srikanth" <srikanth.chary-chennoju@amd.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
	"m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
	"Chris.Wulff@biamp.com" <Chris.Wulff@biamp.com>,
	"tiwai@suse.de" <tiwai@suse.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Kalluri, Punnaiah Choudary" <punnaiah.choudary.kalluri@amd.com>
Subject: Re: [PATCH 2/3] usb: gadget: f_sourcesink support for maxburst for
 bulk transfers
Message-ID: <48be8505-947d-4d45-8a4d-785f36f8047f@rowland.harvard.edu>
References: <20250704114013.3396795-1-srikanth.chary-chennoju@amd.com>
 <20250704114013.3396795-3-srikanth.chary-chennoju@amd.com>
 <cf2940e3-5430-4e84-916b-608c33028a7c@rowland.harvard.edu>
 <CH3PR12MB872633800DDD386DCE8169B6B14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
 <e5f4942f-4a0d-44a6-a2b2-7d567d4d0ddc@rowland.harvard.edu>
 <CH3PR12MB8726F8F10AE2094B5E94861AB14FA@CH3PR12MB8726.namprd12.prod.outlook.com>
 <CH3PR12MB8726A85B8D425323EDDB96D8B128A@CH3PR12MB8726.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB8726A85B8D425323EDDB96D8B128A@CH3PR12MB8726.namprd12.prod.outlook.com>

On Mon, Aug 11, 2025 at 03:36:28PM +0000, Chary Chennoju, Srikanth wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

If this message really is for AMD Internal Distribution Only then you 
should not have sent it to a public mailing list.  Or to me.

> Hi Stern,
> 
> Please let me know if there are any further comments for this patch.

No further comments at the moment.  I'm waiting for you to submit a new 
version of the patch taking the earlier comments into account.

Alan Stern

