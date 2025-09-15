Return-Path: <linux-kernel+bounces-817749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D1B58605
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349FA1AA8280
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D166296BA2;
	Mon, 15 Sep 2025 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZ2+sUIi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9321B5EB5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967915; cv=none; b=C1kL0QK2QXbJJaNuTFOHmdGzgj5J7zb8anISUyqsr6npNa+9Yzw2xTuLsnaxmhoa/W1UKRPv/cQ63FNpPIBu4h5176QRwzYN9r3E8jFwuNre3o2by7Yg2xteNoY4S0QvfCXmyDtu+z56jpKPuAi0vzHxELKFmaLHAcdPv2BGuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967915; c=relaxed/simple;
	bh=Oo9wGMZhnst9JKD4ApAAC3zg3Wq/VvmKzOk8qOj+8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeEUZvPjMj3ga5WEjFJviqEIVOjW72EcK3fSr7YiPoOyd2DkbUwwwMHFoTTIhPWsy+elSsXoUQYVP0efVbhGvUkiVTW8qyjLtLcRJz39YGnBmiPUIjhNItwxKdr7PAtmwAXAwhxEPsn/qtm+7ht45q2ByuuqBQJofwE8WOhVrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hZ2+sUIi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26799bf6a2eso11043115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757967914; x=1758572714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O72yw8vJtQy+8bHFkvEUobUMXSH/AYeLaHaVDBYLJyk=;
        b=hZ2+sUIi9pf3OXUUBWGgpMI5lz3YNtMyjManCGjlhT68Jf3aWAX5gEb5flACSwLeL8
         m2NKLGcinlGwgkrukw+lUQlIYAIY64+ywTzk6KEe4qXidGdBLOw4LqXS+4INsGIDyduM
         P3TVtGcqXTsoY5Pk6PsMJsRqcGMDib280YHfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967914; x=1758572714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O72yw8vJtQy+8bHFkvEUobUMXSH/AYeLaHaVDBYLJyk=;
        b=mjQq+rMywN9++2PELqMriiuAImmuE5t7DLnlx9Su+/HOwgplR98WgDBgp1RAR6rRvk
         JSuzw0+o9Jf3AcDopRRAi8E+hY+BKEfHNfkLxkY5955tbWLRJBSVrWMMritcqLFLaVfT
         l2v7sdS55KHMH0lsfsatdPYWv61gEL8E0cA62hCv+7/PRp/x7J+p+5DT4yaqKYHwUkQ4
         I/o8ZHxN4dRkukZbCw6UbAxlrDAco9RlVbMp+J7KyyYdT3347zjqp7mPi/MkB8OdXjwC
         ykk/sBt05lp02Jka55+ZAFfNx8s0HOlWMRuYEB25WU0IIcDhKvnAN7NbEEBmALkNihuQ
         t4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVw+QcP+i/pRa07VTNGs5hPqV8q1Zt6S5KBC5T0z1bgnwDQASWQqn++yQHflEZG0rHZKBghdGdE3ULLfo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBJKxWyw2uwbneRr2JnIYBQtlIWbZIZQVyntyj5FfsRQZUvJt
	qvRAw9g6zjGpEXzVbNAfQfLSJSgbbFk8ysoiJuBolEKab2sgWMmcRkqfFkiVctBl+Q==
X-Gm-Gg: ASbGncs58nSgUFqGxS8Sgofg8Kc7+3KRyVErZ9fV/sKCEsr6lLpaS8NU4LkZm6GdAWp
	5FHOV1+U/anx1udL7tEpHfiiFQL0fcasppmCcAMWXL9YaEm/XZEiTGdx5zwKhpR79h9miG7TS51
	2h+wt3VPkL4+9tFDdzP9XWCBUcnBaDZDlNXSNdwN/bGz7uz5V2JiSGkUjjazVrt9cd4aq7r/6Di
	7uwEzjKO/UdYhPyg5XYmbvgTrPxvJI3feCaiiLReksF3GnnXNFzP+aEq+HCe0euX2GvbLlCcaGk
	dsQLUpGqOrwFND2nIG/9RwTv0R7s5+DYHOy8cwgd9B1ANakC60Acneajj/f2VoNTUcclVGHqMno
	dwAAjY3GLsKR2AhleS8v6HqnuEGFc1CqAYOMd5mEl2Lq3MY3iyuD4RS7nR3PBR8XRWAQdCwQ=
X-Google-Smtp-Source: AGHT+IH0BB3qybe2HQfIXVITegc2cfF0wfUP7hE62PhWgnHrlmUKZL5W+LGvMXTHhPZvp8uroV0xQA==
X-Received: by 2002:a17:902:ebc2:b0:24b:25f:5f7f with SMTP id d9443c01a7336-25d2801094emr140529445ad.60.1757967913824;
        Mon, 15 Sep 2025 13:25:13 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:fd49:49b1:16e7:2c97])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25fc8285639sm86930085ad.134.2025.09.15.13.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 13:25:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:25:11 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>, linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>, Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 2/4] PCI: Add KUnit tests for FIXUP quirks
Message-ID: <aMh2J1K_YiWYaNxf@google.com>
References: <20250912230208.967129-1-briannorris@chromium.org>
 <20250912230208.967129-3-briannorris@chromium.org>
 <aMfJCbld_TMHPTbD@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMfJCbld_TMHPTbD@google.com>

Hi,

On Mon, Sep 15, 2025 at 08:06:33AM +0000, Tzung-Bi Shih wrote:
> On Fri, Sep 12, 2025 at 03:59:33PM -0700, Brian Norris wrote:
> > +static int test_config_read(struct pci_bus *bus, unsigned int devfn, int where,
> > +			    int size, u32 *val)
> > +{
> > +	if (PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (where + size > TEST_CONF_SIZE)
> > +		return PCIBIOS_BUFFER_TOO_SMALL;
> > +
> > +	if (size == 1)
> > +		*val = test_readb(test_conf_space + where);
> > +	else if (size == 2)
> > +		*val = test_readw(test_conf_space + where);
> > +	else if (size == 4)
> > +		*val = test_readl(test_conf_space + where);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> 
> To handle cases where size might be a value other than {1, 2, 4}, would a
> switch statement with a default case be more robust here?

I was patterning based on pci_generic_config_read() and friends, but I
see that those use an 'else' for the last block, where I used an 'else
if'.

I suppose I could switch to 'else'. I'm not sure 'switch/case' is much
better.

> > +static int test_config_write(struct pci_bus *bus, unsigned int devfn, int where,
> > +			     int size, u32 val)
> > +{
> > +	if (PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +	if (where + size > TEST_CONF_SIZE)
> > +		return PCIBIOS_BUFFER_TOO_SMALL;
> > +
> > +	if (size == 1)
> > +		test_writeb(test_conf_space + where, val);
> > +	else if (size == 2)
> > +		test_writew(test_conf_space + where, val);
> > +	else if (size == 4)
> > +		test_writel(test_conf_space + where, val);
> > +
> > +	return PCIBIOS_SUCCESSFUL;
> 
> Same here.
> 
> > +static struct pci_dev *hook_device_early;
> > +static struct pci_dev *hook_device_header;
> > +static struct pci_dev *hook_device_final;
> > +static struct pci_dev *hook_device_enable;
> > +
> > +static void pci_fixup_early_hook(struct pci_dev *pdev)
> > +{
> > +	hook_device_early = pdev;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_early_hook);
> > [...]
> > +static int pci_fixup_test_init(struct kunit *test)
> > +{
> > +	hook_device_early = NULL;
> > +	hook_device_header = NULL;
> > +	hook_device_final = NULL;
> > +	hook_device_enable = NULL;
> > +
> > +	return 0;
> > +}
> 
> FWIW: if the probe is synchronous and the thread is the same task_struct,
> the module level variables can be eliminated by using:
> 
>     test->priv = kunit_kzalloc(...);
>     KUNIT_ASSERT_PTR_NE(...);
> 
> And in the hooks, kunit_get_current_test() returns the struct kunit *.

Ah, good suggestion, will give that a shot.

> > +static void pci_fixup_match_test(struct kunit *test)
> > +{
> > +	struct device *dev = kunit_device_register(test, DEVICE_NAME);
> > +
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
> > +
> > +	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);
> 
> The common initialization code can be moved to pci_fixup_test_init().
> 
> > +	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
> > +
> > +	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
> > +	bridge->ops = &test_ops;
> 
> The `bridge` allocation can be moved to .init() too.
> 
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
> > +	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
> 
> Does it really need to check them?  They are just initialized by .init().

Probably not. I wrote these before there were multiple test cases and an
.init() function, and I didn't reconsider them afterward. And they'll be
especially pointless once these move into a kzalloc'd private structure.

Thanks for the suggestions.

Brian

