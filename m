Return-Path: <linux-kernel+bounces-740567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840FCB0D5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AADA3AE727
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4B2DCC1A;
	Tue, 22 Jul 2025 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X80OWRUn"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB22D7805
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176142; cv=none; b=faLUyJQYAfblzB4HunUEinSnr5PSi5UFnm3ACDNbPF+IRKd2KEluhRTDIod6Qq+3goQtBAHEouxT3UPWlZnNel3sd59vZY/Ake6wMHgQvidPScOh19h5h+T6DztTr3LbbbnjeNxSrjNZLwyKPN9/ueQeGI7vMTYbMABDIKTQcQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176142; c=relaxed/simple;
	bh=uYr/vN/QU33ReSJvEevEB5MK/+NOdjeWQPyffLoa+I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuJeIvriXsDL0z7EHxZQeaUmYEHCm7p5/dmeGvrH7tjovhq1Agissu5VdUbkZJwkiYf1issv73pQtztZe2/SiVkE6ENjlmSP6TjItAkfVS1kq5er7DbjYvDu8+r561Uk3q+UBHpl1ERf68/QBADxO7B4MYC/mdntOqRk8aQhPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X80OWRUn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so3313868f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753176137; x=1753780937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=68LTZPICfvpdeBNlynhA03OE6AbJLyW/A+yzTWLxPgc=;
        b=X80OWRUnsxH1FGHcf5NZWzUZuyf/aRV+Mg7HmAcm8+aaJee9ftRo/nscJ8K6udhYG3
         0Flexox+s9Ihpi1cF6g1woUQMXZ85bPh1ngGFHjs/MKK3CWp5dsMaLXFakLvw3plE1jJ
         LR2cZ4iIKGXkyqGTR3gW1AnKrHDMFPlr7W7PfB6osEaOe6lyzVyD28hByrw9x8xkga2f
         mLwMubqu45XatAyC/DLlINTquocnIN2k9SKQFEMWBMNuFlqBdkT6rkjicr9JKhJD0vwa
         c7p0++tImueIIC5bzOATFRnAeOXPJ5MmOiuiy3imX0ic84eNGreqmHoYW0952OUtKKGT
         0ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753176137; x=1753780937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68LTZPICfvpdeBNlynhA03OE6AbJLyW/A+yzTWLxPgc=;
        b=CL5tNX3s9sXeJM4CWkcOoLjHYFJwp4CycDzuxpJidirDgxytuQA9bJEQvCWeJYSJHk
         X5KOSxAMnu2a0fCWuf/5cbStfMbVV8BNIaQDzREXngrD8ND+IRPXhjsDQAtFJsHvwcoa
         fFObS3tGudXvWTbGfJ1ejBGsiyuZpyaUWRi/kln/mWmrLVXcXCWbgTvEy2sHslJBvdJ9
         G9bY6LwJUIR39OhQMgpktXoxYIXEO3XPnl/tzLSTcU3ZGki6fuBOnVB0xHhBEw3PiIQF
         iFdCbpQUKwI1PW8IsqG1P2GSdnIfNtqzWvi8K/6fh25pyj/Kma+7LNRpEwld63VpSK+m
         5pGw==
X-Forwarded-Encrypted: i=1; AJvYcCVU08xUNJuEJFOcM+4mazt4SpvB+EO9XKzAW9NptGKnDfZbTEK7gg01N4T5JvqICq2QYiPnz9nXAYRi45w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62ZzeH03wace/cjNOmROSIXrdyyJKlJMwhzEgFmGq0uhn3MiN
	gRnZyg7Y0Cr/CB2LKgj5GIXZDEZ4Hx3xUbb3Ayt5CQLMAkRkfevqgrVZp8dwwS7zU5s=
X-Gm-Gg: ASbGnctQXg6U8xA5051NeIDUI2OGep9fZQuHLzrWyd4Jyg3anZRQ8Dmi76n5agBQJLt
	EObLGRqbC0oiHrcjYyK53MveuppRnHJaYmy0j6i9rVHqTHc1yclPGRXJV2lwG3Q0F5IfdwGzIV1
	OBS61ojYyqY5EIs2s8OKm2DcQhZInkum02AKXZ6aJ+YlsrRmOMGfLLXv13s10ZqtlDY88ZcTr0E
	mkNr/xwsYPUoomFVxXd/184Iv4O+u3unpQgoUEcQzV5g7q8V1BBVYLHKu0VWmWNAnrY+IbLXaXq
	nNZDCDRXvFahgWpLNx1IqUQaFRWA+f280vq+/Njp+jAPlkUO1Z9ejpIARxPSI1w75UChvnG8701
	Cs18nZ1wy2sAAxk88cvpFvkXb
X-Google-Smtp-Source: AGHT+IFVMdgI84AAnBBQz6sZmRWv62oz1HqGcw1SLKt4wi8dXsCWBwHYMMj3blV9NJZQxxpoW0Qdkw==
X-Received: by 2002:a05:6000:2012:b0:3b7:590d:ac7d with SMTP id ffacd0b85a97d-3b763488cc5mr2270468f8f.1.1753176136501;
        Tue, 22 Jul 2025 02:22:16 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2b803sm12548484f8f.19.2025.07.22.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:22:16 -0700 (PDT)
Date: Tue, 22 Jul 2025 11:22:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Fix excessive stack usage in rate TC
 bandwidth parsing
Message-ID: <vabulcn5q5hm4qhiol75cwuztq4wijcjkiw4oy4wjckaybbq5m@54xt4qxhwnls>
References: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1753175609-330621-1-git-send-email-tariqt@nvidia.com>

Tue, Jul 22, 2025 at 11:13:29AM +0200, tariqt@nvidia.com wrote:
>From: Carolina Jubran <cjubran@nvidia.com>
>
>The devlink_nl_rate_tc_bw_parse function uses a large stack array for
>devlink attributes, which triggers a warning about excessive stack
>usage:
>
>net/devlink/rate.c: In function 'devlink_nl_rate_tc_bw_parse':
>net/devlink/rate.c:382:1: error: the frame size of 1648 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
>
>Introduce a separate attribute set specifically for rate TC bandwidth
>parsing that only contains the two attributes actually used: index
>and bandwidth. This reduces the stack array from DEVLINK_ATTR_MAX
>entries to just 2 entries, solving the stack usage issue.
>
>Update devlink selftest to use the new 'index' and 'bw' attribute names
>consistent with the YAML spec.
>
>Example usage with ynl with the new spec:
>
>    ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
>      --do rate-set --json '{
>      "bus-name": "pci",
>      "dev-name": "0000:08:00.0",
>      "port-index": 1,
>      "rate-tc-bws": [
>        {"index": 0, "bw": 50},
>        {"index": 1, "bw": 50},
>        {"index": 2, "bw": 0},
>        {"index": 3, "bw": 0},
>        {"index": 4, "bw": 0},
>        {"index": 5, "bw": 0},
>        {"index": 6, "bw": 0},
>        {"index": 7, "bw": 0}
>      ]
>    }'
>
>    ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml \
>      --do rate-get --json '{
>      "bus-name": "pci",
>      "dev-name": "0000:08:00.0",
>      "port-index": 1
>    }'
>
>    output for rate-get:
>    {'bus-name': 'pci',
>     'dev-name': '0000:08:00.0',
>     'port-index': 1,
>     'rate-tc-bws': [{'bw': 50, 'index': 0},
>                     {'bw': 50, 'index': 1},
>                     {'bw': 0, 'index': 2},
>                     {'bw': 0, 'index': 3},
>                     {'bw': 0, 'index': 4},
>                     {'bw': 0, 'index': 5},
>                     {'bw': 0, 'index': 6},
>                     {'bw': 0, 'index': 7}],
>     'rate-tx-max': 0,
>     'rate-tx-priority': 0,
>     'rate-tx-share': 0,
>     'rate-tx-weight': 0,
>     'rate-type': 'leaf'}
>
>Fixes: 566e8f108fc7 ("devlink: Extend devlink rate API with traffic classes bandwidth management")
>Reported-by: Arnd Bergmann <arnd@arndb.de>
>Closes: https://lore.kernel.org/netdev/20250708160652.1810573-1-arnd@kernel.org/
>Reported-by: kernel test robot <lkp@intel.com>
>Closes: https://lore.kernel.org/oe-kbuild-all/202507171943.W7DJcs6Y-lkp@intel.com/
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>Tested-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

