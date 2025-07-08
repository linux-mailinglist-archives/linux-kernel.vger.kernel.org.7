Return-Path: <linux-kernel+bounces-721784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCDAFCDE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053C91884DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D712DECD6;
	Tue,  8 Jul 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QqZPFzPG"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8142DF3C6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985507; cv=none; b=IqZ+sEca+MLZMabpJlWFFYhxiV455KiG/u3g/piWVF1meZ4um8oL3hSTXDCT4dCjhxAIg5W9WdPBI+vgwBCGpJldlzTt9S5ne1h8DrHzGbkbqDPVse+BcVRpHNZk7zwE/1Y1cGfhkBYHW65Tv5N3jDaYadfmkHbKdS3K0KFTCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985507; c=relaxed/simple;
	bh=CBHiMtF76emACLhNI1i90aU/IPRwdQpe9LQAjVx6bPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qMCHZ7CjSkKRaqmureu6fPcmxI4FeoEyqxV6VCt26avQEh2aw2EI0mLv04J1gutcfvV5s/bNQbgroko7ywKYqfzksR5arXlY5yFKFkVZIvjDCsZiRxjBzL0m00zZMVyJMS5LVrKzUBsfdEbiWSFKBNikHlhMNcPiwdyqO2mesS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QqZPFzPG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4537deebb01so25895715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751985502; x=1752590302; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQa90YOlhA3fJEDfJauE20Ul/hTSJXv7U106YAhQsnQ=;
        b=QqZPFzPGN9hmaBF7rql+a3gdfdRDH4F6eQ4NO+7DfzOO/LzcAaezJ9H/g5EWS/wPEe
         cSgmZoNW+9J3GLETXTnoOZlEc5+qy0AfA9pXg1mSl1ePcRUX8tXMXvbKzWRWL4KUXyWz
         x5z20DTG7tHks5yN9AeYW+e6S4rUfqlnB44iS/GyWRfw1/DRmGwTGiIAPbCLJoYuX6CP
         06aYowcpY5nh2aO8Ppo/pgvv4GlG570xyIQrTrlHW4OWkgERSPJJlwuksnDf36Y4i/E3
         0vuZ3/x/U9q3QVj5xsTOLCwjRFznXuJGVjll++4x6TIt1UaCTAkkHNfdGgWEQZloF3fn
         j5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985502; x=1752590302;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQa90YOlhA3fJEDfJauE20Ul/hTSJXv7U106YAhQsnQ=;
        b=dLzlrgRT6kj/ZAH7s7Jp+J7o8S2TnetM+SLjfhECOR3BF/VEb25iGGGPMz/c8KqclX
         bGbrNe1FIZva0KFp09RZTok/JrwiNkannxsT4t9K1cmyrJBDIaG6awqU+6cJZYYfTz8J
         WlG1K7Z+rYK+/X745JJ1B2HI1SCBFrlRvHIVmxGwqiv1TyjDQtikzBAZ1Z+HmH7HNiUC
         zpca1LfYVEWXC9rw/4+NbpsQevkV361S6he5/UaeN+bCZt9HocxCx4/rQg+cyq3VPn/b
         CUnFAJ0xaqKhO64CeElXjA8e9Rf42hbCX9lzUD5Ag31HHyhFuIEg+EyFfsMkcXFSLBP3
         Msrg==
X-Forwarded-Encrypted: i=1; AJvYcCV5gtpkCXOj0w9YcjyAnwh0SFpQBrzQPbCufNhKlpywKkf9g+RsN9gYbfk6UBDrkqbHS+fQqWfrpCm/xL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa0cwUA76gOdSGt30O8jeTlR0R6hdGTfAJTO8ug9TN34hI0eX4
	p2xxSZnuAAej9/vLrmj1KbY06sP5v86gK2dFheWlWbqlRat2uG94PU7R4TXN0tjE5O4=
X-Gm-Gg: ASbGncsMCEnaMUAEz36gurCWqwHVLAApnKdDCoIRzv6QKCsubc1UG77QKrVNQM0NJ13
	fDZRk6LZHBq76b/OYENZbfbFlWX4Fbu8f8IT4UBA/9K1rPHBYJFxLlyxfJ3kDlVV3WRTNAEgkkL
	xdmhoJpW5z+CvksW9KAvjSptL/bBmXKHHpDVvxciGu110zfH+oFygiKI+T7avBFW0TakGI85jQN
	E0gpxZn/N3AKvxHDROqO2WbzYjhmK2d00mmn676plWNbJsIA+n0CWRQBibUj6TbXztLAwT3Ux5j
	YlbX3LH6hXufHgMaxQ4CPuklbHm/ebm2xSiMcrv5VGosSqxoZDcsZBkhAxoUag==
X-Google-Smtp-Source: AGHT+IGkTAADU5GJBjTfPKjBI8nKUYihH2c/PDjzRAbuVp6cLMSvJODNrGJZAh2zhD2MKlKtONE7zg==
X-Received: by 2002:a05:600c:1c06:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-454b4e682ebmr165857685e9.2.1751985502254;
        Tue, 08 Jul 2025 07:38:22 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:dfdf:dfe3:8269:12e7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cd493865sm24282935e9.24.2025.07.08.07.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:38:21 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Johan Hovold <johan@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Dave Ertman <david.m.ertman@intel.com>,
  Ira Weiny <ira.weiny@intel.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: auxiliary bus: fix OF node leak
In-Reply-To: <aGztOnNKu3gvFH2_@hovoldconsulting.com> (Johan Hovold's message
	of "Tue, 8 Jul 2025 12:04:42 +0200")
References: <20250708084654.15145-1-johan@kernel.org>
	<20250708095908.GE592765@unreal>
	<aGztOnNKu3gvFH2_@hovoldconsulting.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 16:38:21 +0200
Message-ID: <1jjz4irbmq.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 08 Jul 2025 at 12:04, Johan Hovold <johan@kernel.org> wrote:

> On Tue, Jul 08, 2025 at 12:59:08PM +0300, Leon Romanovsky wrote:
>> On Tue, Jul 08, 2025 at 10:46:54AM +0200, Johan Hovold wrote:
>> > Make sure to drop the OF node reference taken when creating an auxiliary
>> > device using auxiliary_device_create() when the device is later
>> > released.
>> 
>> I'm probably missing something, but random grep for the
>> device_set_of_node_from_dev() callers shows that none of them are
>> calling to of_node_put() explicitly.
>
> Yeah, the platform bus code takes care of dropping the reference for
> platform devices.

There is an of_node_get() that needs balancing indeed, Thanks

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

>
> Johan

-- 
Jerome

