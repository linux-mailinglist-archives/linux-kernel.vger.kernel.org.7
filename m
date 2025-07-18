Return-Path: <linux-kernel+bounces-737194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5DB0A8F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B5B3B65DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F382E6D2C;
	Fri, 18 Jul 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dSHZiGBu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24772D613
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857892; cv=none; b=cF+v0/jtaIwqWk3vgjIGzySwDOdYk1CUMJa6kOhh3RJXebv9Rm1ZQApLBBTi2bktcsZiiz1KRMpVSdLX5uKZxVfTFWnuk4iHooaR7Fn1h6V1CQODFBQh42iOkdwUi9luMafliPceWkMYEoEM5erHYdPN4Ic0HUTlE3zqwiFrVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857892; c=relaxed/simple;
	bh=VLW3UWQLxGRdbGgQdSEaWhEmJKomiEjyniwXZIeWPNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSPoZvXa9YoLvdFJTuH1DXMrnli37dPqJobVpRpDF5vGM23GytWt7u1vwq4EsxmqBAD/Evg5tBunlGrAtZXD5U5xUQuSc7lLn/BMwgJLivuxzdDCADzhX3kSir64wgmX2r3JeIY0CdUjGwHXDwgjlwjbLoMULo6QzOPonSDkzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dSHZiGBu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1614128b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752857890; x=1753462690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIjnpXR7kFzmkgbsnqn30ikPUW7z/FzWNSDSSmsQgxI=;
        b=dSHZiGBuWcQwqvuP04xKJ28O1+13I/OeKSA6nUCS5k0S0krUWhmwGEbOsdhAP4/DeI
         J5QTHCEny63CAkflis7lXL9hnh+McWpKhJPOm+2Rfb2UvWTkOfZddWa8fUxWBsFxg1h2
         llguurF+zpeMeMbG3yJ6DQb0XMCyooSyu120VRjzxmos9thKIQVPIZTjJkYHh/OhsGZz
         SYSj3N5BRkCroSoJ2BYmE3+s33viYuuZoBDq0CA/r9C/sbXvuuvUsB4ubjgDh/Lz8w1G
         brGGFHwo9O5xD0fZBckw7teVx0XwYdx31Hl19s4h1UbIfCDYB905OH0+nxNAsNQNO0gI
         FDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857890; x=1753462690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIjnpXR7kFzmkgbsnqn30ikPUW7z/FzWNSDSSmsQgxI=;
        b=AJ2O8b4a7TnoZciu4MVsSA7nyHvOLpxLZ4PekjwofPl2BOZ/Elajln32ZKiBwb6TsU
         vwRhiaXQ10uXqlRK/tieSkJRmL0ub7R97hLn06t0sEOFTKr78hSeJ+TGmhgTorHekakM
         XRo00I/UxZh8SGE/AoZ6q0P7vRPWyrPkoFIIJw9HuhE05bbBfvT6F4Df6rpqXovJAJC7
         tuP94lSnbpfnXI8FclCmWuf3a4Cv2/V43wXxpXH+ButbW7fenK1yIQtyCJk9xEersHJJ
         eRfszrylOklU9+/US8ehVlsGpkcdc2tFV0paK2HUEes62Q26Il6At1BJuopJVMF5bK8U
         8eXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhYfzYolQMi3mrHD38z40bXNwoJpKspYcvNR1watK8phAglK+BEexBTi+n96fDiagJgiSfu7YiKdZHo6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2hPxO3U9xlPFCJccM1LFe6uJUUtxSbsQ0pUKzgasSTkCl1hzY
	IeXhn0cfqfcTt8NGyRShKrCFRqkWmI6Lf3MdaB/FrWSod2tEIKqKO4cBeEy7/+hzf4c=
X-Gm-Gg: ASbGncs3hjI/g4rVhhw9ndI3ryYTiztZ2unOdEhjKe+N6lHgZKG0Pd9Z0gWvqoN0d6Z
	h3n7kpxTNDPHEk0510ZqdfJXBIL3PPywB5HpKvEBusbpC0lyLCulsUnS9kwewffKfxADHwSR78q
	KzQp7KYTfB5KcwZg0qA6O7LgN85OtLm+8vZJgoCfJ9q1/qwgcmTpPnTyJn6hUYJ5CjVoqLNpAy7
	xMRagI3mHiQJpapEziWHK9XrE0sCOGaKOf/TkOJ5qK2xMwa3zb1lH57NVbfAgsJ2+QutiIVJKPh
	JKkLY7z2qPUl04A1PIdB1NL3FK9AbtuAtkWJJmPVHB3t54Dlmbx971LJ6MRfpxaLqddNRFmoFrK
	pTyjBAop8+6HKiKSj0s+8+8+Xlr/zP4vsaPYy9CxoNOGdrhs3xoRwlBAs
X-Google-Smtp-Source: AGHT+IGSYEopSk3acBGxusn+C3aQwEH7Y9k5SO3YHjLM61xU8Uro/IWUb/xfLi/OwISpnyV/yTpN+Q==
X-Received: by 2002:a05:6a00:10cb:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-757242790admr14294927b3a.16.1752857889825;
        Fri, 18 Jul 2025 09:58:09 -0700 (PDT)
Received: from [172.20.8.9] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e20c2sm1551781b3a.18.2025.07.18.09.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:58:08 -0700 (PDT)
Message-ID: <bb01752a-0a36-4e30-bf26-273c9017ffc0@kernel.dk>
Date: Fri, 18 Jul 2025 10:58:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] io_uring/btrfs: remove struct io_uring_cmd_data
To: Caleb Sander Mateos <csander@purestorage.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708202212.2851548-1-csander@purestorage.com>
 <CADUfDZr6d_EV6sek0K1ULpg2T862PsnnFT08PhoX9WjHGBA=0w@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr6d_EV6sek0K1ULpg2T862PsnnFT08PhoX9WjHGBA=0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 2:04 PM, Caleb Sander Mateos wrote:
> Hi Jens,
> Are you satisfied with the updated version of this series? Let me know
> if there's anything else you'd like to see.

I'm fine with it, was hoping some of the CC'ed btrfs folks would ack or
review the btrfs bits. OOO until late sunday, if I hear nothing else by
then, I'll just tentatively stage it in a separate branch for 6.17.

What test cases did you run?

-- 
Jens Axboe

