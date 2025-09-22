Return-Path: <linux-kernel+bounces-827318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394BB916B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E007A3B45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8677730CB2F;
	Mon, 22 Sep 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gxBoL0st"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072E305E04
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548044; cv=none; b=KzvhgfA6Gi9zOkjiGHA/k1YT0ICgzR+96G5t3eqcbmBJ0uz/poZLQd1NpLCzupdLm8INApkvbya+OyIbkiZG2JZJGQ+X74UdXnMjPd4+CpWV51NQ4CKb5rUig46T6moIWv0few2v1IE+1LjoBn+x1caqZXRYtSFT/9kSvEQr26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548044; c=relaxed/simple;
	bh=Yor4x8m5Iu7cFNNhUnaT4ssp7sVaWveTps6qwortWn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alWMjB4CAEpicqlTb9I2Svklqt3V/MnLOPKkPdrW5jf7b/yJAE6qBoqjSN/Dk5Pl/CHL/pBi/fSLBO3VYVXIBAfhh3OVyP2AF3xaFIqcKBabwJxwVrMOEe6LuQxu2bcZQveAVISRLgnp6ep1p6lA4q/OnobozJjFxMSSKX/MiuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gxBoL0st; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4d1c5c3f77eso1300901cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758548041; x=1759152841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToJEbemIomM/hxYhKH1W7Ss14J28ndazNgTozXT+KoA=;
        b=gxBoL0stWvAsL5vEbZWIvnMVjsi39TPDynUrdyzERzdY6hJ/sPad3nkbiWCzi4OSC8
         Y9t/5kA+fZZiq3/ja9KXe4Dwhwh+/MFjlKbOT1XUKchONPM9hTrWUZafdXBYaBeiwnGL
         SKcgzZtBb1Bd+2WVtuhUQf0DYoDeFPEY8ZoXfopg72EmQHczFvf6tDt4vPGF8vMQSKEW
         K0IFFFjsRLG229rpkMxxHJVNMZo378KruZAmscYMhrHtlG/6ULV0DRTQBRTB8DFKMnGa
         1dWg3OadgDUuLhkmtAJOZw3IVuqq/Y8Q7hVALM+JMnKhZm9cUBNF9RN2UgUo5GpxRrB1
         U3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548041; x=1759152841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToJEbemIomM/hxYhKH1W7Ss14J28ndazNgTozXT+KoA=;
        b=V8NAgQNmo0UUswo54YHjyhjoNRAkaUSiRkX2Rti5XcxVOT/XcTV4gmm0THDvDfmfwd
         riR+DT+TZdiDB6cFsDJY8tIuLvwM+NXj1AycVy3rWx3DlRtRipcYmZ/ldFbFWI7pOdOq
         Qo9TESd9Yj2R9fZh/4IVZb2vj0h0w0QHmPGIN/rz9Ndqa6DimgDTyyKpMT1vV9t2kDXg
         DIHHGnk272QmqavePMyGwBt0ZDO1ZiPzjPs65unT0zkWusATgR1LeSv3BZt6mm69+QMM
         N2AxlHFqTJGWps7lEVmb85TLgEDmEycjUL5Rs178zztMtoD4EBpGp9V4f2bcvvWRj88Y
         fZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo1xg7+wxBXlUVipig/KFEOl/sn3GIJxhmEICEBu3BrvxOEkuknemt9zAttjZFKg10hU5LQQWDDJbSMTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKhlYe3Gz68cBowhgipomZcx7OtNGTMtjcEGG01rNAVljOeHe
	Sx8vsv4NNcQm0T+O5cXHFpDi4Q1AY6QsxZXIZbQTjS9sUYP/BYkBAXhwoZXLByNcaYU=
X-Gm-Gg: ASbGncvuHG0qbNuT5bDFWYV+q2FyvCJnHnX1bkNdwnn1zA2/mzStYzdkRtB7/dG4eOf
	ge+3qfAqpaVFSYKLZrLVNJ5u3Qkhqlb8j4t20rIpb8CkxEV2RXza6JgF5+dsVtDbCX6swNREc5N
	wTWQtdrB9EoMJRTPMxFYk6LpKmYyGxSBTE1piR7zxiy6Igt6BIF/fSWSvayH2fZqtEMctBDinHE
	w8BtfLFjBWsMqIPELyQAvimhJ/iuU7eEy7WymA76x6xRMZi1ZLjDYMnc5eKBOjAyooPxX3SD++z
	eUZYc53M0ZdY0kq/kmmEPO4eRwKiFJBzYWWYYiyTRInPK3lQESy9DTt6KjRpqKIb8npX0w8z
X-Google-Smtp-Source: AGHT+IGXIFmUrc7BjBo+C3ndSlS9KFerdTMQurYi/ZiTtHJGiOi2JR5vLU1lsTM1PhCHlKgNZNgMdg==
X-Received: by 2002:a05:622a:a0f:b0:4b1:1fe:dcfc with SMTP id d75a77b69052e-4c03d7af72dmr202015381cf.16.1758548041169;
        Mon, 22 Sep 2025 06:34:01 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4d0c9a15c4fsm4291121cf.2.2025.09.22.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:34:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0gg3-0000000AMPp-49ws;
	Mon, 22 Sep 2025 10:34:00 -0300
Date: Mon, 22 Sep 2025 10:33:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pds_fwctl: Replace kzalloc + copy_from_user with
 memdup_user in pdsfc_fw_rpc
Message-ID: <20250922133359.GA1326709@ziepe.ca>
References: <20250917150941.168887-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917150941.168887-1-thorsten.blum@linux.dev>

On Wed, Sep 17, 2025 at 05:09:41PM +0200, Thorsten Blum wrote:
> Replace kzalloc() followed by copy_from_user() with memdup_user() to
> improve and simplify pdsfc_fw_rpc().
> 
> Return early if an error occurs and remove the obsolete 'err_out' label.
> 
> No functional changes intended.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/fwctl/pds/main.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Applied, thanks

Jason

