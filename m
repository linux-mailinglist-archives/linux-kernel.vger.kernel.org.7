Return-Path: <linux-kernel+bounces-788617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D6BB38750
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD3C3BE312
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8224A288505;
	Wed, 27 Aug 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhDp5Wik"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D532D2489;
	Wed, 27 Aug 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310763; cv=none; b=Cihu/ofdN/lHbCEXCeyh4rCrct6gQ5iU8EpcPRvUzt1a8jqOY7r1e+5V2s4bFJzZgkzSZP0RROSbtrKjMvEceR51nPDn5Dflzxugy8lB210GS/snXL55EV1tjl7VmeKbTvfRZXUJWUYOX3yx3vM6leNl8jTklTAJTq4t05UPROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310763; c=relaxed/simple;
	bh=odA5mMJ55s1mCBU0IKreRgNTvT1A3V4fAJvsBshUb1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lf2NyrFm3s+QJiHHugQdycTbqfulRmDv8LFc0iveT7JYjlpUdnjHvVfun6tF7TxNtuTLtWuA9CurQ1tO008v5n7O31KzyC/5Fx7F9Czcy2WJt/ixFM8v5t1wQ2AFGyJY1gQK9sw+1aAujlJ590LtWWMj6cAY3FNVGEpXbgl6XrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhDp5Wik; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso54215a12.2;
        Wed, 27 Aug 2025 09:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310761; x=1756915561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMfuQyLL4GDOfCjCJ80Nb/bJQ4amEX8OmrLR5q7CvJI=;
        b=VhDp5Wik4d+Gf0YIVnuNp0SApj94kb9hDmOdzITl9POKmkitFjyAlcjqXcOZ3AruH2
         h4//vnKV1Us6xGryq5QCBhllrmn4+LBVuwPgfi87LF41DQfsClADhDKAkRDpRYQ14uNx
         wPQrzsqEYsk1muFfRxM3ywscHCRy/YKX+ujIrc52V0S+6iy8XBNiPY1FZa+1e24HGEnU
         iaEe7w6UOpPk1r56WfXsutqgR8bydI/PJIODjHiG/n9cKIjNsddBKtwaeVHwYNVg8Bs0
         iV6/AVWooCoWRJvCTY3647rTqoaGJZVosc8t/crEbPxOm7bsqIdNzlS0nZURXTzEJ8Fi
         3zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310761; x=1756915561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMfuQyLL4GDOfCjCJ80Nb/bJQ4amEX8OmrLR5q7CvJI=;
        b=Jb9gGkFXGMjibzBBsip/2Cd7N7Nm7hRW7/6lKO3igplVZ/4Y/mHu5pBJ4mJo/nUn4T
         m4fwaojAOi7r3+4fzigFFNUNfCk/KJW0kNY/rJBBzaYGAYQdnoBGCxx7mk9k9KUXFWLd
         9CkTixW5g/Y2hToLbNfXhdiIFj1p9u12OnoY34HwC9wsH7VZ2hWVRCMkm97C16wmRdXE
         +RchNBsbTTORm/brnvSP3Ncdx1tLnLtWDl45mKiTylO0w6tIxojkejND4SdWRmHGOtse
         NO+C6Kio5+U4R8yPpqXA4UM0CAWhGUCT6sQD7aLEJBs0vHMPbH7HAqK8Xo+21QJrPydJ
         7SPw==
X-Forwarded-Encrypted: i=1; AJvYcCXUEQ2wDIZPgSKPYsFlYeeKcQ4enBcSTLVrMAI34TGJug7jlGcdPkSQu/pOJX3I2je33bDhyG5VqSONBQ==@vger.kernel.org, AJvYcCXxyexbjKZ+kq27D6kBvictR2cB8DDoCxqHzxo+Ae5iqIKyEy4hFlLhrml3wwHL93kFJTzBIOJrq+gTRfl4@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuDtU5Hn+2MKxGXsW6+t9DiNRSTaj+KZrs2qLFyIHpNALmVqw
	5o7tao19ripSaVoxDc78vXPDIgyIeNjSqDuEiaao97E50AIB8JdbMKuA
X-Gm-Gg: ASbGnct8DiqYUZes+F+cUiBQE2skj2xyuX1T6qSLL3LCNpnxSSP5hzZ4qWHPyljFIOQ
	PnJlKpB+L8JEF4t1V9kp7UvQDOCYzeFcqt+NCB88vbt+rH+kdR86JtIDYjawvEtHGAUWc844q7h
	3R55x+/aocBVRGevU+SZFwlbPhIMSts10bvNbEhnDon0wRuIKbAbU5r48zYV2RAaZT2zskx1wxe
	T4Wf9wRZn+ycPCNfMDD/dzpYDaN7yEKJnKyaapv84IqQiguErxui7OKSCJ8tTtPOGs+RPU0HQeE
	GQIOCR3zED19JtnTrljBlZsxmvyEiON9wIWJMBwYisPO5NuzF19DRsuUOze+tPj/0IPUZCmQcWq
	9z7pi1isQHoIvNKSa7SOS0UI8Pp6vz9q99gQ=
X-Google-Smtp-Source: AGHT+IGDA1GjtaZxeeMWHRL0K5j+8nPhGU9oZHded2tgcpuE/4DJEW3x8v0psE+Kt9riQ2nlemTNZQ==
X-Received: by 2002:a17:902:cec2:b0:246:61e:b564 with SMTP id d9443c01a7336-2462f1d82c4mr242283585ad.61.1756310760658;
        Wed, 27 Aug 2025 09:06:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248d072dc87sm54425ad.108.2025.08.27.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:05:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 09:05:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chuande Chen <chenchuande@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuachen@cisco.com,
	arun.george@amd.com, groeck7@gmail.com
Subject: Re: [PATCH v3 1/1] hwmon: sbtsi_temp: AMD CPU extended temperature
 range support
Message-ID: <17937838-ccbd-4c28-914b-f4a8c33093f9@roeck-us.net>
References: <20250810084307.41243-1-chenchuande@gmail.com>
 <20250814053940.96764-1-chenchuande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814053940.96764-1-chenchuande@gmail.com>

On Thu, Aug 14, 2025 at 01:39:40PM +0800, Chuande Chen wrote:
> From: Chuande Chen <chuachen@cisco.com>
> 
> Many AMD CPUs can support this feature now. We would get a wrong CPU DIE
> temperature if don't consider this. In low-temperature environments,
> the CPU die temperature can drop below zero. So many platforms would like
> to make extended temperature range as their default configuration.
> Default temperature range (0C to 255.875C).
> Extended temperature range (-49C to +206.875C).
> Ref Doc: AMD V3000 PPR (Doc ID #56558).
> 
> Signed-off-by: Chuande Chen <chuachen@cisco.com>

Applied.

Thanks,
Guenter

