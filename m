Return-Path: <linux-kernel+bounces-874356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE77C161DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22DA4F2EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F634B1A2;
	Tue, 28 Oct 2025 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C73AZuOZ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D307234A766
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672124; cv=none; b=oPwRPg/B32kTmzca0h1VLkd4FrtCDzC01rHmdo1XM7VZJjrrw/osSU0gxpP20oT0SYG666OQUfP2Speid9FJDvojphTJIQ4vqcm3L/ylDwvBZKaw7hPZTa+LknWAdwrsqU5ASkpVRtp7bwOF2NXGLWtPMcjvmifENy3POBH8Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672124; c=relaxed/simple;
	bh=2WfCIauAeO/IafVNMn762pL+WqvpKOkad1Pqpqj+dNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcF+e6mHL8WUxrU6RhqpCjhzXJChGAGe6OMG8SgEQv3Z95QtgvAEvLNfP6Psg8L5zYV5bdHHTvhbwmyAimTN8CjyMSYIa/GeBkRQOWAGTX6YJmUocl3a/0VzL+DCXijS4fI50qWyHdsmXdKuWze//2xAvUQ6gf6w4VxYfHOLcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C73AZuOZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7930132f59aso8254682b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761672120; x=1762276920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ji9p+5aFdf+kyAe4VXVfYLigSD8K9niEZ0dfK3EfFg=;
        b=C73AZuOZCu8HxIY9o7zqNTwV1yKbNLrTso/jLMhiiaSLIt9AOtgrp7TBosoATmCYw1
         /wYMiXkU6FFroMSYCHOkSbrglguNPIlm6kpdojfvOwRV666zJvYXV909riQlXMUocygS
         7qZEsVBGUyKrx+XORYKr3/+yue3agFKJ4zmoLYkQKG9l9CIt/0a3mUUmsvpl2AU/vgJA
         +mbIAc7g8C8xO+iQRKvcIvlxNC0boH/L1LhiH2FBjfXfyJmErEXELxITmsZV3YNtXVjA
         ZEoeUKY1fdP3sZXFram8/qFMbYgqtbnEckvgMMocnYfo1n+/dolBNWYdloixUW05a9ax
         c3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761672120; x=1762276920;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ji9p+5aFdf+kyAe4VXVfYLigSD8K9niEZ0dfK3EfFg=;
        b=l8BzvsauItfF1PoG+utj9495q1tinkzYzmwY/lOE5IywemIpc2lAo/x18kkNCNPJMt
         U4VdPnguUJf1dLnytMtYyAA6jRQZyl3ozhRJ9xNpaLh19Fnls9uObS0eq3h8t0N/F3P/
         0/q9vvxXCocRtILKQAAnhvucTQmLUiSmU4O2sENQExLnCvNPipL3IfOrNa33c50sX2Ao
         uCrDpyvBaFruXXLiAX8owTM8VPp1f2Xeqk7Y0QzsEmMyDzkO0tBrNBrjXM2HVjDF+wpA
         O12rMqVrbrKZ0h/w9PeUXDOoH0xIF0qbpHmPC3aQmLU5zLiGno3PmIsIm5BI9jFwkTWi
         qHsw==
X-Forwarded-Encrypted: i=1; AJvYcCW1f6fuKk9eQFRr6h/rmIEH0vob4LJRQGkUVSQfPrr4rzVNdtotTPW+bCQ6MRSFl15b/JFdcGUSpSaQr6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKpB6NwahaW3rXe9hIyx3aLbm0uLLVxkZqV58j5Jh+gCEZOSPV
	b+QWU+hJXBUhzXltAYCBpW7YMcJaPYDOjC32wZSN4yTjmhOLC8QnkM9E
X-Gm-Gg: ASbGncvtrbg7CYAVacTt8W8+OGedSLjVCBkowcBNRpuSqIeog3zhdudZHlZMThrRtUa
	12DJgL7x0/HaB9JkHU09gIvSanOxldzmB7+ly47KGaCnjyUUjBAEiwK4sJEDypjvDgQ5TBeNpUa
	o+txB2kytkv7Db3zyvKabbBX1PtrJBq8lRfNjBMJCN+6EC1YhlWLpmNLvULsY0QTw+va1SLyYuX
	Ly96OihAYtbdimver7X+dYmIAtAH66NwsWMl1WQfOvDeiQsSlDVAYKtKs3rBWA5HxvV6Xh0EHAY
	nVPKrfxyE+Ke8JmMbbUSJMxyLWmM2oN8xg2GFMZM4GiFORkhupVkYO6WMtXyxHdJ3aiSOy4YSQx
	8ZWVeDgoOPfxTPfAN5x8HQwzKZbXveuf2exY4ukF+tzUDoeFyIcc2xqvG0Dd5E2dtItZNSvcEAb
	11ZimMFVAx67Ou6jBPd/JJqe4ITgvMObTyv86Fde46O1LvS8PNfFk=
X-Google-Smtp-Source: AGHT+IFtZbks/LCgEhtL7Zva/ZYA9CYkpa381vRQPs+p+XdXEi0Ofj/XtgImdGrU8z8bq87Mfrq5xA==
X-Received: by 2002:a17:902:f68f:b0:265:47:a7bd with SMTP id d9443c01a7336-294cb3765f7mr43053915ad.4.1761672119918;
        Tue, 28 Oct 2025 10:21:59 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e416a2sm122441205ad.97.2025.10.28.10.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 10:21:59 -0700 (PDT)
Message-ID: <79c65e1c-dbc9-4a16-b718-af8e227b6290@gmail.com>
Date: Tue, 28 Oct 2025 22:51:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ethernet: emulex: benet: fix adapter->fw_on_flash
 truncation warning
To: David Hunter <david.hunter.linux@gmail.com>, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20251024180926.3842-1-spyjetfayed@gmail.com>
 <370bb59c-ff99-449d-a3ae-f091bb33f029@gmail.com>
Content-Language: en-US
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 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
 TRpGew2ozniUMliyaLH9UH6/e9Us
In-Reply-To: <370bb59c-ff99-449d-a3ae-f091bb33f029@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/25 11:31 PM, David Hunter wrote:
> On 10/24/25 14:09, Ankan Biswas wrote:
>> The benet driver copies both fw_ver (32 bytes) and fw_on_flash (32 bytes)
>> into ethtool_drvinfo->fw_version (32 bytes), leading to a potential
>> string truncation warning when built with W=1.
>>
>> Store fw_on_flash in ethtool_drvinfo->erom_version instead, which some
>> drivers use to report secondary firmware information.
>> send
>> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
>> ---
> 
> Hey Ankan,
> When submitting patches with version 2 or afterwards, you should
> generally put information about what changed from version 1 to version
> 2. This changelog helps people keep track of what changed in subsequent
> versions.
> 
> Also, did you do any testing for this patch?
> 

Hi David,

I had used the wrong formatting command which resulted in a bunch of 
changes, most of the changes are due to formatting issues which is why I 
had to send a [PATCH v3].

As for testing the warning during the build is suppressed by this patch.
It was not tested on the actual hardware.

Should I send a [PATCH net v4] with the changelogs added?


Best Regards,
Ankan Biswas

>>   .../net/ethernet/emulex/benet/be_ethtool.c    | 100 ++++++++++--------
>>   1 file changed, 54 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
>> index f9216326bdfe..42803999ea1d 100644
>> --- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
>> +++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
>> @@ -221,12 +221,20 @@ static void be_get_drvinfo(struct net_device *netdev,
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>>   
>>   	strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
>> -	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN))
>> +	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN)) {
>>   		strscpy(drvinfo->fw_version, adapter->fw_ver,
>>   			sizeof(drvinfo->fw_version));
>> -	else
>> -		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
>> -			 "%s [%s]", adapter->fw_ver, adapter->fw_on_flash);
>> +
>> +	} else {
>> +		strscpy(drvinfo->fw_version, adapter->fw_ver,
>> +			sizeof(drvinfo->fw_version));
>> +
>> +		/*
>> +		 * Report fw_on_flash in ethtool's erom_version field.
>> +		 */
>> +		strscpy(drvinfo->erom_version, adapter->fw_on_flash,
>> +			sizeof(drvinfo->erom_version));
>> +	}
>>   
>>   	strscpy(drvinfo->bus_info, pci_name(adapter->pdev),
>>   		sizeof(drvinfo->bus_info));
>> @@ -241,7 +249,7 @@ static u32 lancer_cmd_get_file_len(struct be_adapter *adapter, u8 *file_name)
>>   	memset(&data_len_cmd, 0, sizeof(data_len_cmd));
>>   	/* data_offset and data_size should be 0 to get reg len */
>>   	lancer_cmd_read_object(adapter, &data_len_cmd, 0, 0, file_name,
>> -			       &data_read, &eof, &addn_status);
>> +				   &data_read, &eof, &addn_status);
>>   
>>   	return data_read;
>>   }
>> @@ -252,7 +260,7 @@ static int be_get_dump_len(struct be_adapter *adapter)
>>   
>>   	if (lancer_chip(adapter))
>>   		dump_size = lancer_cmd_get_file_len(adapter,
>> -						    LANCER_FW_DUMP_FILE);
>> +							LANCER_FW_DUMP_FILE);
> 
> Also, are you simply changing the tab length here? Any particular reason?
> 
>>   	else
>>   		dump_size = adapter->fat_dump_len;
>>   
>> @@ -301,13 +309,13 @@ static int lancer_cmd_read_file(struct be_adapter *adapter, u8 *file_name,
>>   }
>>   
>>   static int be_read_dump_data(struct be_adapter *adapter, u32 dump_len,
>> -			     void *buf)
>> +				 void *buf)
>>   {
>>   	int status = 0;
>>   
>>   	if (lancer_chip(adapter))
>>   		status = lancer_cmd_read_file(adapter, LANCER_FW_DUMP_FILE,
>> -					      dump_len, buf);
>> +						  dump_len, buf);
>>   	else
>>   		status = be_cmd_get_fat_dump(adapter, dump_len, buf);
>>   
>> @@ -635,8 +643,8 @@ static int be_get_link_ksettings(struct net_device *netdev,
>>   
>>   			supported =
>>   				convert_to_et_setting(adapter,
>> -						      auto_speeds |
>> -						      fixed_speeds);
>> +							  auto_speeds |
>> +							  fixed_speeds);
>>   			advertising =
>>   				convert_to_et_setting(adapter, auto_speeds);
>>   
>> @@ -683,9 +691,9 @@ static int be_get_link_ksettings(struct net_device *netdev,
>>   }
>>   
>>   static void be_get_ringparam(struct net_device *netdev,
>> -			     struct ethtool_ringparam *ring,
>> -			     struct kernel_ethtool_ringparam *kernel_ring,
>> -			     struct netlink_ext_ack *extack)
>> +				 struct ethtool_ringparam *ring,
>> +				 struct kernel_ethtool_ringparam *kernel_ring,
>> +				 struct netlink_ext_ack *extack)
>>   {
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>>   
>> @@ -737,7 +745,7 @@ static int be_set_phys_id(struct net_device *netdev,
>>   						 &adapter->beacon_state);
>>   		if (status)
>>   			return be_cmd_status(status);
>> -		return 1;       /* cycle on/off once per second */
>> +		return 1;		/* cycle on/off once per second */
> 
> I'm not sure, but it looks like you are adding formatting changes to
> code that you are not necessarily changing. Is my interpetation correct?>
>>   	case ETHTOOL_ID_ON:
>>   		status = be_cmd_set_beacon_state(adapter, adapter->hba_port_num,
>> @@ -764,7 +772,7 @@ static int be_set_dump(struct net_device *netdev, struct ethtool_dump *dump)
>>   	int status;
>>   
>>   	if (!lancer_chip(adapter) ||
>> -	    !check_privilege(adapter, MAX_PRIVILEGES))
>> +		!check_privilege(adapter, MAX_PRIVILEGES))
>>   		return -EOPNOTSUPP;
>>   
>>   	switch (dump->flag) {
>> @@ -873,7 +881,7 @@ static int be_test_ddr_dma(struct be_adapter *adapter)
>>   }
>>   
>>   static u64 be_loopback_test(struct be_adapter *adapter, u8 loopback_type,
>> -			    u64 *status)
>> +				u64 *status)
>>   {
>>   	int ret;
>>   
>> @@ -883,7 +891,7 @@ static u64 be_loopback_test(struct be_adapter *adapter, u8 loopback_type,
>>   		return ret;
>>   
>>   	*status = be_cmd_loopback_test(adapter, adapter->hba_port_num,
>> -				       loopback_type, 1500, 2, 0xabc);
>> +					   loopback_type, 1500, 2, 0xabc);
>>   
>>   	ret = be_cmd_set_loopback(adapter, adapter->hba_port_num,
>>   				  BE_NO_LOOPBACK, 1);
>> @@ -920,7 +928,7 @@ static void be_self_test(struct net_device *netdev, struct ethtool_test *test,
>>   
>>   		if (test->flags & ETH_TEST_FL_EXTERNAL_LB) {
>>   			if (be_loopback_test(adapter, BE_ONE_PORT_EXT_LOOPBACK,
>> -					     &data[2]) != 0)
>> +						 &data[2]) != 0)
>>   				test->flags |= ETH_TEST_FL_FAILED;
>>   			test->flags |= ETH_TEST_FL_EXTERNAL_LB_DONE;
>>   		}
>> @@ -999,10 +1007,10 @@ static int be_get_eeprom_len(struct net_device *netdev)
>>   	if (lancer_chip(adapter)) {
>>   		if (be_physfn(adapter))
>>   			return lancer_cmd_get_file_len(adapter,
>> -						       LANCER_VPD_PF_FILE);
>> +							   LANCER_VPD_PF_FILE);
>>   		else
>>   			return lancer_cmd_get_file_len(adapter,
>> -						       LANCER_VPD_VF_FILE);
>> +							   LANCER_VPD_VF_FILE);
>>   	} else {
>>   		return BE_READ_SEEPROM_LEN;
>>   	}
>> @@ -1022,10 +1030,10 @@ static int be_read_eeprom(struct net_device *netdev,
>>   	if (lancer_chip(adapter)) {
>>   		if (be_physfn(adapter))
>>   			return lancer_cmd_read_file(adapter, LANCER_VPD_PF_FILE,
>> -						    eeprom->len, data);
>> +							eeprom->len, data);
>>   		else
>>   			return lancer_cmd_read_file(adapter, LANCER_VPD_VF_FILE,
>> -						    eeprom->len, data);
>> +							eeprom->len, data);
>>   	}
>>   
>>   	eeprom->magic = BE_VENDOR_ID | (adapter->pdev->device<<16);
>> @@ -1074,7 +1082,7 @@ static void be_set_msg_level(struct net_device *netdev, u32 level)
>>   }
>>   
>>   static int be_get_rxfh_fields(struct net_device *netdev,
>> -			      struct ethtool_rxfh_fields *cmd)
>> +				  struct ethtool_rxfh_fields *cmd)
>>   {
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>>   	u64 flow_type = cmd->flow_type;
>> @@ -1140,8 +1148,8 @@ static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
>>   }
>>   
>>   static int be_set_rxfh_fields(struct net_device *netdev,
>> -			      const struct ethtool_rxfh_fields *cmd,
>> -			      struct netlink_ext_ack *extack)
>> +				  const struct ethtool_rxfh_fields *cmd,
>> +				  struct netlink_ext_ack *extack)
>>   {
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>>   	u32 rss_flags = adapter->rss_info.rss_flags;
>> @@ -1154,7 +1162,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>>   	}
>>   
>>   	if (cmd->data != L3_RSS_FLAGS &&
>> -	    cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))
>> +		cmd->data != (L3_RSS_FLAGS | L4_RSS_FLAGS))
>>   		return -EINVAL;
>>   
>>   	switch (cmd->flow_type) {
>> @@ -1174,7 +1182,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>>   		break;
>>   	case UDP_V4_FLOW:
>>   		if ((cmd->data == (L3_RSS_FLAGS | L4_RSS_FLAGS)) &&
>> -		    BEx_chip(adapter))
>> +			BEx_chip(adapter))
>>   			return -EINVAL;
>>   
>>   		if (cmd->data == L3_RSS_FLAGS)
>> @@ -1185,7 +1193,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>>   		break;
>>   	case UDP_V6_FLOW:
>>   		if ((cmd->data == (L3_RSS_FLAGS | L4_RSS_FLAGS)) &&
>> -		    BEx_chip(adapter))
>> +			BEx_chip(adapter))
>>   			return -EINVAL;
>>   
>>   		if (cmd->data == L3_RSS_FLAGS)
>> @@ -1211,7 +1219,7 @@ static int be_set_rxfh_fields(struct net_device *netdev,
>>   }
>>   
>>   static void be_get_channels(struct net_device *netdev,
>> -			    struct ethtool_channels *ch)
>> +				struct ethtool_channels *ch)
>>   {
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>>   	u16 num_rx_irqs = max_t(u16, adapter->num_rss_qs, 1);
>> @@ -1237,14 +1245,14 @@ static int be_set_channels(struct net_device  *netdev,
>>   	 * combined and either RX-only or TX-only channels.
>>   	 */
>>   	if (ch->other_count || !ch->combined_count ||
>> -	    (ch->rx_count && ch->tx_count))
>> +		(ch->rx_count && ch->tx_count))
>>   		return -EINVAL;
>>   
>>   	if (ch->combined_count > be_max_qp_irqs(adapter) ||
>> -	    (ch->rx_count &&
>> -	     (ch->rx_count + ch->combined_count) > be_max_rx_irqs(adapter)) ||
>> -	    (ch->tx_count &&
>> -	     (ch->tx_count + ch->combined_count) > be_max_tx_irqs(adapter)))
>> +		(ch->rx_count &&
>> +		 (ch->rx_count + ch->combined_count) > be_max_rx_irqs(adapter)) ||
>> +		(ch->tx_count &&
>> +		 (ch->tx_count + ch->combined_count) > be_max_tx_irqs(adapter)))
>>   		return -EINVAL;
>>   
>>   	adapter->cfg_num_rx_irqs = ch->combined_count + ch->rx_count;
>> @@ -1265,7 +1273,7 @@ static u32 be_get_rxfh_key_size(struct net_device *netdev)
>>   }
>>   
>>   static int be_get_rxfh(struct net_device *netdev,
>> -		       struct ethtool_rxfh_param *rxfh)
>> +			   struct ethtool_rxfh_param *rxfh)
>>   {
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>>   	int i;
>> @@ -1285,8 +1293,8 @@ static int be_get_rxfh(struct net_device *netdev,
>>   }
>>   
>>   static int be_set_rxfh(struct net_device *netdev,
>> -		       struct ethtool_rxfh_param *rxfh,
>> -		       struct netlink_ext_ack *extack)
>> +			   struct ethtool_rxfh_param *rxfh,
>> +			   struct netlink_ext_ack *extack)
>>   {
>>   	int rc = 0, i, j;
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>> @@ -1295,7 +1303,7 @@ static int be_set_rxfh(struct net_device *netdev,
>>   
>>   	/* We do not allow change in unsupported parameters */
>>   	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
>> -	    rxfh->hfunc != ETH_RSS_HASH_TOP)
>> +		rxfh->hfunc != ETH_RSS_HASH_TOP)
>>   		return -EOPNOTSUPP;
>>   
>>   	if (rxfh->indir) {
>> @@ -1309,27 +1317,27 @@ static int be_set_rxfh(struct net_device *netdev,
>>   		}
>>   	} else {
>>   		memcpy(rsstable, adapter->rss_info.rsstable,
>> -		       RSS_INDIR_TABLE_LEN);
>> +			   RSS_INDIR_TABLE_LEN);
>>   	}
>>   
>>   	if (!hkey)
>> -		hkey =  adapter->rss_info.rss_hkey;
>> +		hkey =	adapter->rss_info.rss_hkey;
>>   
>>   	rc = be_cmd_rss_config(adapter, rsstable,
>> -			       adapter->rss_info.rss_flags,
>> -			       RSS_INDIR_TABLE_LEN, hkey);
>> +				   adapter->rss_info.rss_flags,
>> +				   RSS_INDIR_TABLE_LEN, hkey);
>>   	if (rc) {
>>   		adapter->rss_info.rss_flags = RSS_ENABLE_NONE;
>>   		return -EIO;
>>   	}
>>   	memcpy(adapter->rss_info.rss_hkey, hkey, RSS_HASH_KEY_LEN);
>>   	memcpy(adapter->rss_info.rsstable, rsstable,
>> -	       RSS_INDIR_TABLE_LEN);
>> +		   RSS_INDIR_TABLE_LEN);
>>   	return 0;
>>   }
>>   
>>   static int be_get_module_info(struct net_device *netdev,
>> -			      struct ethtool_modinfo *modinfo)
>> +				  struct ethtool_modinfo *modinfo)
>>   {
>>   	struct be_adapter *adapter = netdev_priv(netdev);
>>   	u8 page_data[PAGE_DATA_LEN];
>> @@ -1417,8 +1425,8 @@ static int be_set_priv_flags(struct net_device *netdev, u32 flags)
>>   
>>   const struct ethtool_ops be_ethtool_ops = {
>>   	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>> -				     ETHTOOL_COALESCE_USE_ADAPTIVE |
>> -				     ETHTOOL_COALESCE_USECS_LOW_HIGH,
>> +					 ETHTOOL_COALESCE_USE_ADAPTIVE |
>> +					 ETHTOOL_COALESCE_USECS_LOW_HIGH,
>>   	.get_drvinfo = be_get_drvinfo,
>>   	.get_wol = be_get_wol,
>>   	.set_wol = be_set_wol,
> 


