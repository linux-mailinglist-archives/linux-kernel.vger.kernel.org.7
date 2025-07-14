Return-Path: <linux-kernel+bounces-730673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6961B047F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3839D3BC339
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D722A7E9;
	Mon, 14 Jul 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrsPwXzu"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CB1FE451
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752521868; cv=none; b=sp4xGKnrf+coo5dNAak6wVaLr8f/Ip8lXFXykWEqfrfiUcNADhrPbds3d2GZhjLDd6ldYEmdeA+H4Q3H40kZBopnGipZkvvXa8/9tyl6dMPjmzaaRI0nMqNGsP5EYcE2xEefcsGzndWBPBuExEU7xbY05nDm9Q0nZB9QkC0vEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752521868; c=relaxed/simple;
	bh=r3KO+ZBs4mN082/WzjFPu6+tKInahyanTvO0ZCUAo/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NYc/bt83bou2WuCV0rpWyNZTqhmHNVMKjyA97wunJU+6DSEAiNRDFAiCGCDoLI+OezN5/x+I375mdFNoT4xTyRdXyxa4wKbRNsWousnITqOA3BAbHvAFp10nUHldlh/Y+GtyC7IMHJljdcSQyhSWGvX3lfguYJrxR+/CkwT+Z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TrsPwXzu; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-735a6d7c5b1so2745754a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752521866; x=1753126666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sP/J78YSZFnZNYcFRTT3/TqZZq4tSvgtl6O7DciL3GA=;
        b=TrsPwXzuu5S+SjzRHJM4Ljplet3/tn+FzAUYaPewiO4Lhw/kIQc7oKrmZvj8U1vLxE
         JBYEcXOWuGEGpNi6sI4rYyvNxUpZOiQmlq6yngUN+fAjvUzfI29ARoMvxATz5HGPuuNF
         5LbXjMGeDbRzBdCPhYKZemnedfchNYimNZcz1bwM2OOuZzwkuk1RMaN4KdYlBpEnuK46
         Ire2RQ8bVR9pwya/wv2Q7Uyhx5+x1QgG17vzl8tBab+NLFx7n5ChdJfDfU/ARCi0fRCR
         zW0utb99kCEJ6i0oOzdAzNoA/ueUNiRPQ0xJelMJe5Cdj70XA0NCNg+stuWrmCu6cFuD
         3CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752521866; x=1753126666;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sP/J78YSZFnZNYcFRTT3/TqZZq4tSvgtl6O7DciL3GA=;
        b=mKP37S6xp/C0n0jty4lemw/5n2ZdL8FCrSe4kd80oIubqelNl4SqmqsLQvJpOEFTti
         GRTAye9J/6331z1DwqwggbQz75DixQ6geiwP6fgPfeTTibhsEaT8RCVd5RPOnuMxWTjY
         K8swOTrNXtKiLoVv7kGpRRkOSgShE13RImiMGZlHICkD8H6wSJhhhPoRDs7uGlKmfDGZ
         aYTRUaS9WO78miiQmC/Wiuk6Imzso/YRrAV04JGJASHOaQH1cGLIAVAKlueD4V2Bn2kU
         yi+e8gGoB1QwPmAtKl4JIbtkpm8tZGdxowVU2Ps6UTS/sekHcvqS84EGMVvbRfbCbZn6
         t1hw==
X-Forwarded-Encrypted: i=1; AJvYcCUIE6OyQikC4vPohSibGBqmGRfXtpOBp7JHxJ79ufOGREMZgatae9n6Z0YsLx/pwEoRVj8nGSYBDFUJP6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzun7K5pg14NIR9SIOBcXE6z8lBhPzvhl+Y8yF/v6N17ew80GK2
	drXpkWA5/W0d+M0HN1mgtBVi0PRCId0GG1rYh9oTbbTazsj6grRdszSBbG31gnOFxo5ha9VpfJN
	DzEYU
X-Gm-Gg: ASbGnctoRn5ikM45RJE1VG19kGecAKBFnO4IxLKN4nmlZaR18l08MX03Ez9yq9bypCz
	dHxHsoeWDA3fvsXbozFX9sPTftnjijwrEKuLwJqEd/xYTC3XVcnhyWop+niWMrkqquxDGhl4hHO
	L9To1eNaB165Aoq3czn6VoWD9LkWQVxTkxvNrpXjbc1JGHiZL2eundna+BdFD4sfNJifgRiFiwD
	ws8BthB9I0gSxTIZ3VYACgHtrHTxmW9nRk4muBQWHb3cKyRWsM921ivYElqpne8xoTKE0G+RglJ
	66m3JVCT5ur+rXM7+Xfuo+3LAz2X03E+OlPJEKwJGIyLRUgux/MzkacvvR0+p4FEuCqAtEa42id
	LrOnhSassubACKiqjQCXLt8HNsMhCTA==
X-Google-Smtp-Source: AGHT+IFErlbQA7v+YncKKuLD+GZLIWHCFOI/036UbG1GrAOyALCZ86WcXDhbFE3hQMC28zdAmyVLWQ==
X-Received: by 2002:a05:6830:7105:b0:72b:8aec:fbd4 with SMTP id 46e09a7af769-73cfc2b4cacmr10268075a34.3.1752521866082;
        Mon, 14 Jul 2025 12:37:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6bb2:d90f:e5da:befc])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73cf12a609esm1658573a34.53.2025.07.14.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 12:37:45 -0700 (PDT)
Date: Mon, 14 Jul 2025 22:37:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, admiyo@os.amperecomputing.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management
 of the shared buffer
Message-ID: <3806fc87-e574-46cf-98af-158c37f640e0@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710191209.737167-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mailbox-pcc-support-mailbox-management-of-the-shared-buffer/20250711-031525
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250710191209.737167-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH net-next v22 1/2] mailbox/pcc: support mailbox management of the shared buffer
config: x86_64-randconfig-161-20250711 (https://download.01.org/0day-ci/archive/20250712/202507120609.Myazax08-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507120609.Myazax08-lkp@intel.com/

smatch warnings:
drivers/mailbox/pcc.c:498 pcc_send_data() error: uninitialized symbol 'ret'.

vim +/ret +498 drivers/mailbox/pcc.c

86c22f8c9a3b71 Ashwin Chaugule    2014-11-12  490  static int pcc_send_data(struct mbox_chan *chan, void *data)
86c22f8c9a3b71 Ashwin Chaugule    2014-11-12  491  {
c45ded7e11352d Sudeep Holla       2021-09-17  492  	int ret;
bf18123e78f4d1 Sudeep Holla       2021-09-17  493  	struct pcc_chan_info *pchan = chan->con_priv;
e332edef98ddac Adam Young         2025-07-10  494  	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
e332edef98ddac Adam Young         2025-07-10  495  
e332edef98ddac Adam Young         2025-07-10  496  	if (pchan->chan.rx_alloc)
e332edef98ddac Adam Young         2025-07-10  497  		ret = pcc_write_to_buffer(chan, data);

Hi Adam!  :)

ret is uninitialized on the else path.

e332edef98ddac Adam Young         2025-07-10 @498  	if (ret)
e332edef98ddac Adam Young         2025-07-10  499  		return ret;
8b0f57889843af Prakash, Prashanth 2016-02-17  500  
c45ded7e11352d Sudeep Holla       2021-09-17  501  	ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
c45ded7e11352d Sudeep Holla       2021-09-17  502  	if (ret)
c45ded7e11352d Sudeep Holla       2021-09-17  503  		return ret;
c45ded7e11352d Sudeep Holla       2021-09-17  504  
e332edef98ddac Adam Young         2025-07-10  505  	pcc_hdr = pchan->chan.shmem;
e332edef98ddac Adam Young         2025-07-10  506  	if (ioread32(&pcc_hdr->flags) & PCC_CMD_COMPLETION_NOTIFY)
e332edef98ddac Adam Young         2025-07-10  507  		pchan->chan.irq_ack = true;
e332edef98ddac Adam Young         2025-07-10  508  
3db174e478cb0b Huisong Li         2023-08-01  509  	ret = pcc_chan_reg_read_modify_write(&pchan->db);
e332edef98ddac Adam Young         2025-07-10  510  
3db174e478cb0b Huisong Li         2023-08-01  511  	if (!ret && pchan->plat_irq > 0)
3db174e478cb0b Huisong Li         2023-08-01  512  		pchan->chan_in_use = true;
3db174e478cb0b Huisong Li         2023-08-01  513  
3db174e478cb0b Huisong Li         2023-08-01  514  	return ret;
86c22f8c9a3b71 Ashwin Chaugule    2014-11-12  515  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


