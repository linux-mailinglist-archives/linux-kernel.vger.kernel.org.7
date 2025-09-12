Return-Path: <linux-kernel+bounces-813365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B917B54431
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB256736E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91482D46AC;
	Fri, 12 Sep 2025 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="NHfPqkBO"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735D2D29AA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757663494; cv=none; b=nmSzpSO+gRttn+C0xLf4vMecBE2Usy2AFkcEZ01qhMMxyCIrzWnXktghX2j5sLuxuH9yYxnHEJVTKNSza3ZMx95016rLhk3RWw/o+4OkD8AynSpvfoCEeoSMQyZZo+6Gi64o7tkSOsUBhlRDSq4DFiM006Z5pxFkc94UoYqT06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757663494; c=relaxed/simple;
	bh=/nCOtAcnhP6iXsdPDKExHl6CEK70Rn3V1zWzjtGkAjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHVXZi7I66nQBAWq/Kw1DUbDRp9jAYndjVSycaC22DjbrGVt3tkZ2+bKu9UOjsJi3HLr6D9pl9+TNPtH23PrGm6z5OaJdHI3wyu9LiYFuTVRSkX6pUDL03Emkyx6N9ChYJa9Apny4ueTX9ORlOBUM8gz1EeC7p33l6J1N4p7koE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=NHfPqkBO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-772301f8a4cso2229789b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757663492; x=1758268292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5dGuAanKwsiY1ZqsKVkDAIjfNLSeHC2vPf4ogltoWw=;
        b=NHfPqkBO6IpVqSz6f+1Cnc18yRXdyF9DjK/HXMiE6pXswUizb6G8718m76bb+VW5Rk
         QDHXyq5y43TSQR6JQfKncB1ydlE+HLHQQahiRz91cbKABkOjtRDIxC8SJ7dou8ufBDD/
         scfhgN9ujlASqXvtj3UjnEfqkHQnj0gveUfWcIWdKbXxDW8vo81Wuf7eEpen5AGRH1Rg
         IHRxLGMgB+Fp/dp3mA71hr22XWxdo+l3S0+CV16HVlyCHKCHJYKOK1zS09zNQ4Mh7iAD
         zK9EB25ddpb5qr0ZC+ifHbZ1DoGE4q0DqVIIqYjeaMG4ToJktcYGlsHiPxpfqOAT9dBG
         /T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757663492; x=1758268292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5dGuAanKwsiY1ZqsKVkDAIjfNLSeHC2vPf4ogltoWw=;
        b=n1+uTphz9hGBrHLao+juQwvXj9uYwsayS5ZKoihHz8OaHT+lT0zCreYR7PmtlPhcuH
         TPA9j3Az8Q6KGW+B1nojDRWxj0QhNYmDLY/s5ijojCc9vdEOVL5vXTmWwKkbrEmgE3Ei
         kq0kb6m1S1KhRBwFWqHRZCNUxCDhuasY4iSsBwIKRj/2qWC/4nSbgUjJdNf/Opv1+KHl
         Um+oc+oLdc6I5Xku0/jH4ikk8HoAVsXjQ/NggLKPAxORhPqK+LTz3Tz5XRuBaEWHkfgG
         K0uDFfcTyq4VDbvYnDtbd2RY/ylEjJ+jekY7gIUhkFHFsrfTc96rq12Ib/N+IKxIhyOB
         b1jw==
X-Forwarded-Encrypted: i=1; AJvYcCXEJ9lKnBf+E2a/GqlA2odMxfucAhCVCzMGbKsjmFv5hmQFS4oKsSR2VJ5PTj0TdEhX4Fam4d0ubgdQrTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLqdUXM32X3rPmTkP6cY3RajJ/exzGc2i1QbgbKvOpQgS48sb
	EEhatmw724eZEUozl0/ydxbeB0uduaBuBQJG3BBSlI3JPWpmn5x0esBeiggQzm1j5TY=
X-Gm-Gg: ASbGncs/+G0dmKEg+S5YyXky5BaeGyJCcuHVQqQnZo1j6P0o7lOp8Sekd8te2R7ynD2
	hPgpNZZI64SpWYMgkud2NKQLrr5cpjMtyO+/aveMSix54Rwo2fYll2+vbl+OmR3gBrZKOZrGNGD
	SFmrLbJ41V/aUk43BZuS2K4yb/95Rlz7RY6uvt1uQuZMFFh2clqfHepjmVCeQhEkA2OO8GorUvv
	/tcMQzswbzjmjCm7QjlgEY1spIqtCketYFBUJGmQlFxvhBC7xcdYocYx0SWqiArHO6EhqwC4FkR
	yFodKslkG9sRqSAeipVCeUHspFQXiD1SZ7SsTcftfjKnkEI5YIM++6XOtdyR+v4PvQyfkn1cuqS
	GuRF/RG5kTOYz0haUz94AbyHUtT3QRGaS1oW1v4YuzqnZ
X-Google-Smtp-Source: AGHT+IFtDrLHbUf9AliWqdyLS/y+bqUNiq48Oi6Y5dHmTb/VowvDyGiDtwNlsYwwblHsCPFZzZ+p4Q==
X-Received: by 2002:a05:6a20:7d86:b0:24e:a19:7e91 with SMTP id adf61e73a8af0-26029f9e7f9mr2593600637.5.1757663491712;
        Fri, 12 Sep 2025 00:51:31 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T ([2001:288:7001:2703:9e14:1074:637d:9ff6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm3880886a12.50.2025.09.12.00.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 00:51:30 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:51:26 +0800
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: Eric Biggers <ebiggers@kernel.org>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 4/5] fscrypt: replace local base64url helpers with
 generic lib/base64 helpers
Message-ID: <aMPQ/sJJmgpZvDsY@wu-Pro-E500-G6-WS720T>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911074556.691401-1-409411716@gms.tku.edu.tw>
 <20250911184705.GD1376@sol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911184705.GD1376@sol>

Hi Eric,

On Thu, Sep 11, 2025 at 11:47:05AM -0700, Eric Biggers wrote:
> On Thu, Sep 11, 2025 at 03:45:56PM +0800, Guan-Chun Wu wrote:
> > Replace the existing local base64url encoding and decoding functions in
> > fscrypt with the generic base64_encode_custom and base64_decode_custom
> > helpers from the kernel's lib/base64 library.
> 
> But those aren't the functions that are actually used.
> 

I'll update the commit message. I meant base64_encode and base64_decode.

> > This removes custom implementations in fscrypt, reduces code duplication,
> > and leverages the well-maintained,
> 
> Who is maintaining lib/base64.c?  I guess Andrew?
> 

Yes, Andrew is maintaining lib/base64.c.

> > standard base64 code within the kernel.
> 
> fscrypt uses "base64url", not "base64".
> 

You're right, I'll update the commit message in the next version.

> >  /* Encoded size of max-size no-key name */
> >  #define FSCRYPT_NOKEY_NAME_MAX_ENCODED \
> > -		FSCRYPT_BASE64URL_CHARS(FSCRYPT_NOKEY_NAME_MAX)
> > +		BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX)
> 
> Does BASE64_CHARS() include '=' padding or not?
> 
> - Eric

No, BASE64_CHARS() doesn't include the '=' padding; it's defined as #define BASE64_CHARS(nbytes) DIV_ROUND_UP((nbytes) * 4, 3).

Best regards,
Guan-chun

