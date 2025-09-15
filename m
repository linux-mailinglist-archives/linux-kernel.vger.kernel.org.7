Return-Path: <linux-kernel+bounces-817434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31BB5821B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6298B7A7BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173329BDA3;
	Mon, 15 Sep 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kYdiNsCR"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD95266B67
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953806; cv=none; b=h4iTWT4P12UEG/i8mZQV9SobVIKAdFeSpdlPTT79FL7tqZbGWAgiKkJjnnpNhydU9rs+L18AIL04y9zOleb3UIhKBX3VYwc2QD/Iu9wo8gEE+mePzSM09leghC4ZuAHZnyI3GzjkpbeE5fKIHlPR/V5k4V7bBjsChLg++Z/v5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953806; c=relaxed/simple;
	bh=vUGjtDlWHqc7aYh89cQ36SLdWbgpmL9Jq5i3Isp4Wl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtPt1zFCsmnwPbgcYX1YFFqO5DqYfy1Aq85sSsrGuieR4WmljI0lLw4J5BWd6mEfNopIzdNw20qYrA9T6XBQIsL8yFX71LCI1rfBcq0FIqq1Jz9dYALNXOWUJdRj1Gmb0JLIGh07PvwBEtpqKn1fgd1WuHJpaxmbBtS0lqbHfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kYdiNsCR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-721504645aaso35018816d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757953804; x=1758558604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1VOOirKbSUY53Upw24PRoYLUiz7i9vMoYI+GCjhpHs=;
        b=kYdiNsCR/WAaLi+ucyGBMO55xkRQWg+vfVDdKi9hfZfS/41uCtHVCzTonDFSnlxXNM
         /XqLbwEMiK6pczgd/oXzDVnYiFpkc8omOLk/XRkehg8eb6YXXLWLS/MPAkU4ve60Jvwk
         vBcLd+gkAgK2EVCkwqTgsg75nYWmOMpi5YCN3hrx7gGSPbybl81pMhE09zz9dwKWlHMn
         ZigJdJ2mm7kFSjU6Xr5O6VzkfIf4iYBQiV+2GqqHTJHHG2XAsLalVE6k24k08y81LmUa
         nZrnWSnyC7kX9RogGqCgfKaQdssCKAywhsZ5LpksgWuTmlKO4ULi/0W+jHSSiKo6UBjS
         1T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953804; x=1758558604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1VOOirKbSUY53Upw24PRoYLUiz7i9vMoYI+GCjhpHs=;
        b=BuceeBbctkLANYdkj5UsxPsf+NrU8/8rxMQoFf0gMxRo64ObYlfQswoVd8f0W1jK1i
         atv/hlQYcyZQhOl3jTh0c+wj/qb3vf8zg/EGMMdcP943WxJ13mXA+HTGTaUXxJow9Ekw
         3Y5mRJvNU0wL/dg6wsQMyz10gRRYADQ1qV4lWPB6NPG5ri9oSfnh/deNauMXU4LHVXk6
         s0KDEv7NFTZB1SkslWbR7/nGI2I/PfxeK7CLP8cOsxK65ncUeqOjTOwJyx4qdClh1enw
         60E7HMPpNZG92700fKh1DtpqRP1lizrKkjFz9KAiiaJUUV0P0uHm3GhkQVhWqoR/bIC7
         YlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqEzIu6AeNbGSStW6Sgqu3n6z+K2ZlHeoiYhzY0U8J1pnsoWygamC6rGO2rJR4SEDBA1NQfVCVsWiP2pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAIdDU8tPj9VBiPjqw0NhIpYcf97U0SzuYLpbRhhuv2je6LLV
	7LRrTkVrf01uXzOtI6bQ7gb1cUFrL0AkqPXtYe536qcWKmKVAEnlSj/87eRZhtpLk6k=
X-Gm-Gg: ASbGncu5+Px2Rg3z4VF849HsJ3j4HA1ignRY4xNhOBq0Oc5FpirWOhc9lycZ+xh2Fwb
	qvzIu7jzDlL/l/YMYhajTopAZnKiFWhVLUcaT/tzvfN53mNlnsi6xqzZVGUh7/J4rv0T9+zNrZf
	Iuka35WOmZK+EeRDtGL0d/tmXBBxcK2c45DTe5z5i9uoY+VAzo81yYOIXWpgZN6/sZuXzOuabLa
	IGM0BAGojDPf90dfOtmshbJCX3Ybbe59RMs6SoDWsE4LkrhkbXUWUKpb8tbRQjdD1cxQcurCr4m
	OX52DFoDhw8KLn3pLt8MPSt4cIPN+CE0LwxMm3augHg01g9UlUC0O+mneaqXd7dFuSrA9Y3r5Rk
	S4nQ3Tqw=
X-Google-Smtp-Source: AGHT+IFpYayzIAQ2DLYNp4GTlaAjiT/s2zeuAVfqLIyN4DNy83AQcUYuU8GaWSr9Jp9eLTdSRXR9Bw==
X-Received: by 2002:a05:6214:27c9:b0:78c:9dd7:d97e with SMTP id 6a1803df08f44-78c9e242532mr5385896d6.51.1757953803412;
        Mon, 15 Sep 2025 09:30:03 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-781f4401f3bsm24381986d6.65.2025.09.15.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:30:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyC5a-00000004TDO-10U1;
	Mon, 15 Sep 2025 13:30:02 -0300
Date: Mon, 15 Sep 2025 13:30:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Parav Pandit <parav@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 2/4] RDMA/core: Resolve MAC of next-hop device without
 ARP support
Message-ID: <20250915163002.GJ882933@ziepe.ca>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-3-edwards@nvidia.com>
 <20250910083229.GK341237@unreal>
 <CY8PR12MB71954BE7258390B4B7965E8FDC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71954BE7258390B4B7965E8FDC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, Sep 10, 2025 at 10:55:36AM +0000, Parav Pandit wrote:
> > > This leads to incorrect behavior and may result in packet transmission
> > failures.
> > >
> > > Fix this by deferring MAC resolution to the IP stack via neighbour
> > > lookup, allowing proper resolution or error reporting as appropriate.
> > 
> > What is the difference here? For IPv4, neighbour lookup is ARP, no?
> It is but it is not the only way. A device may not do ARP by itself but it relies on the rest of the stack like vrf or ip vlan mode to resolve.
> A user may also set manual entry without explicit ARP.

I think it was just a mistake to use NOARP this way in RDMA, I looked
in the git history and there was no justification. That or it was
right in the 2.x days and netdev moved on to the current schem.

I expect to just call the neighbor functions and if they can't work
for some reason they should fail?

Jason

