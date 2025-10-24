Return-Path: <linux-kernel+bounces-867941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E3C03FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732323B6F83
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F319B8635C;
	Fri, 24 Oct 2025 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rXCYDNrM"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134C78F4B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761266985; cv=none; b=PSx7KS1veiwjAQf6IeyyzBpw89HLBcVHehEFSm3f84IzrpCUBXjI8mRgGb/y/auohqiNBx9lDMf41gvwbkbzBTWHTPmTrmX375yi0DoVc4miG/qz4mHImsCj9CAZ1iUf0dSiZBuEn/eLvwO7wghOHcofE8GwDsWcIKNbKpNN0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761266985; c=relaxed/simple;
	bh=7u+IjDwO6+F7DI7uchGCYv5muBEp0ShcxZa0CbC1aiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Of0SA8iFWZo5CHbcNvC/XC3Ktn2wM/40d01l4TIcplbdQ+5Y54YaD3PuuF1OvLAU2phpU3Lm4Svysyy5jpPUq/jlwZIUuQ2N6ygGzijfpRqJuI60fWqvprxGN97JyQmWaBHHSsmIZ57N+9XFNM67KpR1en/GC0RwsAqv1rWmJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rXCYDNrM; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430d0d37fd7so7521005ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761266981; x=1761871781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ot+UoxjARjoK5fUaxnFU+2GwMHtgeInG0/YoXF7TxQ8=;
        b=rXCYDNrMYFCw9u0WghcoDsLKCv/4E5b4qvWM/pFPeOaGu4IW0ZXFaJJO7ugBzUuqUO
         k3HN3Wr57Vd8+55BiPXzXar8H++dPsA2NVyeik05IV0E9KLRTkN8noUjnq9i46JMbQSJ
         Re+HTiGJHQPzHodwJOVh80fhCg8/bZMOstMvuIn+20uOINwJOIftsAOY4o0Xv0NnOnUQ
         Xxj6fYu33ZuvyxTiLL5EhoPoCnn9cAxBpoFbjXkssU9W2AXI+mZHNLT3DhJdY7Go1sKf
         yPCMIFlS3LtB4n0nS6Hart8bjVFLzuBP37B/zNX6U3sndRFQxn5q8JJSrfEk8xAfZBYz
         LOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761266981; x=1761871781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot+UoxjARjoK5fUaxnFU+2GwMHtgeInG0/YoXF7TxQ8=;
        b=dwjt8xTQBkigdWrS66iHEtBzN4wu6jNU40STy/D/h4/ZfeXreLllLlRm7ZvhogE8Hy
         HcRF7U/RJCX6gAeAam4m2cRVFHiv49no28H2L1uhCi7sGG+ZZWUdCqqhDG+y4kPriuet
         kuXH2NEWP0bCFkC+zHqIDkhKmf+51kl6Ke1Q6txNTBYMB5SLd8rKAy5kWZgn8cC5JRBh
         w+mk4oMq+MzyTNMZL46EuuOWGOj7r2F/brD0wJlMTveXn9vVb2Ki5YBegWhZutTf4R+V
         UFrSVwPeywvhi2pq9pHsvOXg5juI2i+YSK/QVVauTF8+H1LHeb4vg4RUDar99R4I7yRi
         YAmw==
X-Forwarded-Encrypted: i=1; AJvYcCWe5oa/5OzG5NNzaT0eNutkcwffuBH8h95orLhjxIxS8dJBghDeQtGfDQieO+VSl0GM6VR+BHkWWPL8r4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/+cGgBX45Lody4iHfV1pY+T5+iR5wMDwxMfpi07HPeMqq4cU
	KtA8/APyZtt9M5orj1tovlHuQEMGVCMrkNVByVm1TRRsDrXOyRJOF4NTKja6Em0G4P8=
X-Gm-Gg: ASbGncstm32eehRB8bfgA484P/TfGtnX2dRIQPzqTcPVsDUIs9qZTmOHbT3WO4aaADa
	NP9w0D24iNQIdJ4gbb6Xk0Yb5efjQoCniNF9jq1I084CeNQpyEm3V3cLOJQ7TkyWxoiFnA7h0ae
	/CDiW8tw+lx68uhesGwG0B0gwajtKWJ0JkhQ6o81QQo4xwQR0tJlxSwnxEJWoqUxpIYmzRxAGEV
	9mYsetYllBzfR1UrfJQ1Ecqkk2j7QiFIY1YamoX0pKES/ZXOLlKfm6hghDkiFgz6KNmqPAW8eto
	ErOR+rGNfo4l8A3VxrxtIooXcw/FgNVm+bJW9kN9dulc+E8EuNA8cDeV8AK2S1HwWI8+jik1yH/
	iGfBOrg0cHAqdvvTA2hawNl3QNR8uQQnz+tSH+ZvajqVtsQafs6sSv6+QcNe2f/KKuHchRvCFse
	YptJdLhkTE
X-Google-Smtp-Source: AGHT+IGgigrSLGkxt4zqVhLYINQi5KhGC+zpYsJYbgrYE1F3EibqxIYRXytZsIarOnG4dRBIH9FH3w==
X-Received: by 2002:a05:6e02:220f:b0:431:d685:a32a with SMTP id e9e14a558f8ab-431eb624025mr12439245ab.6.1761266981533;
        Thu, 23 Oct 2025 17:49:41 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431dbc8540esm15916115ab.29.2025.10.23.17.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 17:49:40 -0700 (PDT)
Message-ID: <3cc96d17-f77d-4163-a018-eeaff2e8ebd0@kernel.dk>
Date: Thu, 23 Oct 2025 18:49:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_uring_show_fdinfo (4)
To: syzbot <syzbot+a77f64386b3e1b2ebb51@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, kbusch@kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68fa9c5e.a70a0220.3bf6c6.00c9.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68fa9c5e.a70a0220.3bf6c6.00c9.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz invalid

-- 
Jens Axboe


