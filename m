Return-Path: <linux-kernel+bounces-751991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6947B1700E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E4A1C215E2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1CA2BE041;
	Thu, 31 Jul 2025 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bzFimen+"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495D2BDC29
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959749; cv=none; b=dyj5vu95f2zRyvERt66RWKBKiTvdxlVxUKlgXTjk/63QjTNnJ8yE+oWB2GNPbfmeWl6TcENhk6UyCF4OiGmdC7kX80dxcmD6LVNe6eRLoHOIAHfchmGZK4jnoOQ0bHlH6ThDIJp8ypZEKnynL6ZImtgHPm48MIqhOa7lKqfIpMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959749; c=relaxed/simple;
	bh=5RrsDYRSGZWbgt+/toz822ZTd5rZMrQVtU/4uvgxrTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McQagN5sHlcLZzt+NLvFaPJAwemHtN9aLxoTcbaYUrjoAb+yxIlI6YvBwhN5IIZloVwk/LrJuruda//1QIE7EKFFfEyV8QWQKkEp9cF57SyHngkgja/MtKaTPH+l/cf2A41u9MWJNUN9abtZh5G7qGluL94+76lQvrJbNV8fxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bzFimen+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b785a69454so531435f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753959745; x=1754564545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RrsDYRSGZWbgt+/toz822ZTd5rZMrQVtU/4uvgxrTc=;
        b=bzFimen+wqTVmX83QNKhdZnN0/4gnS1n5dJjXooWX4BTNH+3+G45dZuy1VcpzkXAjL
         QBE5JgJEcFF4FPVPrknzOq6eIgic8LfAp+33DtuK8VxBWrujxt8tdoj/AKDnS3QotO07
         zxICwu3Lee5SWtd7qn0kY8ELwpccJrOXupRe4juWkewiqmOCDJ7Z69Dj3U9gd5m4W1+w
         DRWNQxaJy2X+0aZZHGqZxkRmVeXy2ndAmDO4m5x/mCC2e5njfWnsVjJ9l4YmqtaO6SbR
         E4YbUE0NLAH1Btvg1ERRTuOpi2C9gQHNyATGGMxdMeLLO5o85i9wNXyvb8JyfVBJnYPd
         L/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959745; x=1754564545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RrsDYRSGZWbgt+/toz822ZTd5rZMrQVtU/4uvgxrTc=;
        b=FRyaXs6Thq+btvbeUj4hwq+oC80fGs600KhlVBzbdVxFY9VcLRX4B9TjfCYYvAVjOb
         sUqAEh/TDNcgp0P6Xi9m8tyzruym58AF+7RbACcGyrMSDb1ITE8rja4deKc6slrIWLus
         UfcFLDNMqYnvfYVy//ZezmMq5M0n8ZDvnJKDeOcmsc346mmRaHxVRS6HFSyfDGBNY8IZ
         jmRg/dyl+ZlscX59x9KuS8FrV0Jwx1hoOWZSuQFjtddZruwU3DxBkpriojORwDlJ4vJO
         OYX5HWDjfEyjtCJaznc/FA5TghwwIpE1mwOyQb+huQtAv/kSTPPua9vsDCc0zaCmEIq5
         /Azw==
X-Forwarded-Encrypted: i=1; AJvYcCUFceUNXQLR+TZFs2L6IPgqJjSjcHh+fS58VqCvmtf9Lz4Woybq9+EYuSlKTCY8d17NVXr/IFH/1Emy33Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EPIzT3Yv7yDPJLLy8ZHhqG0XM8EHW8NZ3nW5R8B34wUk3acG
	DurRwqDxfZTgyKglemH1ON3YqTQHykjkyxrbiPqKLcBrvc48IN6CEOl2IK4VuX087KA=
X-Gm-Gg: ASbGncso8ndNZ1+eK1c+bBTfCsu9wu/0cfkxoZOPnS6VHV78LeIfDxWFuB9lNXRcNsM
	b1WlVJ/6ZXNb+B3qVeH3qA2nEQ9w4V84Z1a06jykfT9PIvR4sp6eoBNB/QURtlrkSvyiHvimU2q
	NpX0FIFgx+GmUvFBQSgMlLqT46QgsEAQ3lAttN8P9xDOr/SEFf6C18WPhLMo7BQB/qCguE45krl
	q3BkAC0oDCHbIHwiQoInkxy2LDJsBxRUCkMe1QAa8s93vO/BglY1qEoIiTXxDDXPT9Gj+m9xCP9
	FOu2YW2yuv82ZHp2Nv4f+kHT89F9z/stH1DYMdsDMkRv9KBB4WAJCrcJOj3S0B1KMEXo/ev1bHe
	zMTY/GD0eFG7bzd5P6m3RjzzZLhEcFNgSZDo=
X-Google-Smtp-Source: AGHT+IG2/YDknmEESe5rNKpjwCrNrfPKzRjwLoe34Qq7Sxv+j/EwOrCLSeP7CTB/gVBWYK4E+WkoyA==
X-Received: by 2002:a5d:5f54:0:b0:3b4:990a:a0d6 with SMTP id ffacd0b85a97d-3b794fd5a7bmr5115544f8f.19.1753959744629;
        Thu, 31 Jul 2025 04:02:24 -0700 (PDT)
Received: from jiri-mlt ([2001:1ae9:6084:ab00:1d82:e38a:3dbb:d3d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469b4csm2024096f8f.56.2025.07.31.04.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 04:02:24 -0700 (PDT)
Date: Thu, 31 Jul 2025 13:02:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"almasrymina@google.com" <almasrymina@google.com>, "asml.silence@gmail.com" <asml.silence@gmail.com>, 
	"leitao@debian.org" <leitao@debian.org>, "kuniyu@google.com" <kuniyu@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH] net: add net-device TX clock source selection
 framework
Message-ID: <tmp2xu6wrgjk43oxzvzpt7gqb6tdgncwhhapjg7jkmhpb525zd@uxabkfcpbghg>
References: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>
 <p4tnkuf3zh7ja45d4y2pas6fj6epbqdqdqtfai2vmyul3n43lf@v3e5dvvbphiv>
 <SJ2PR11MB8452713FE8051A2B18E742DE9B24A@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB8452713FE8051A2B18E742DE9B24A@SJ2PR11MB8452.namprd11.prod.outlook.com>

Wed, Jul 30, 2025 at 04:09:03PM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Sent: Wednesday, July 30, 2025 2:26 PM
>>
>>Tue, Jul 29, 2025 at 12:45:28PM +0200, arkadiusz.kubalewski@intel.com
>>wrote:
>>
>>[...]
>>
>>>User interface:
>>>- Read /sys/class/net/<device>/tx_clk/<clock_name> to get status (0/1)
>>>- Write "1" to switch to that clock source
>>
>>I wonder, if someone invented a time machine and sent me back to 2005...
>>
>
>Probably temporarily, but this was quickest to invent :S
>
>Creating a single DPLL device for each PF/port seems overshot,
>Could go with extending netdev-genl

That would be my first choice.

>Any other ideas?
>
>Thank you!
>Arkadiusz
>
>>[...]

