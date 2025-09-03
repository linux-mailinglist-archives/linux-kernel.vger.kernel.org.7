Return-Path: <linux-kernel+bounces-798675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D9B4214E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70714542D31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A31FAC4B;
	Wed,  3 Sep 2025 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="uOWaxw/G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LHwVWWlV"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAB3009E4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905658; cv=none; b=pySodfJBDfNlxzvo336cw6WwkUOVLlu86bnXQ1sgMPIIKIGAyiQXUU8vJzBj/29TiamJ9NwxvaR+rggd6Kf969YjiCkf47SRn0P0r2EEBkKCxM8uuLJnv535BujgRfZOCH/qTRZbIyyZLQtt+eoFFMEOFvf958Hg2leNQEeT3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905658; c=relaxed/simple;
	bh=x1NhgUldzH7JCZWqS27ameCWSSVznQnVqWKNMy4/ivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR7IB3DlKiRssls1R++MJBv2L77MBphcm1hhwPBcCiqV8C92pS3s6GQ1S3EaDvwJ6csubXlOZmW0VTJa9ouaQY2YtL9hgxFoWyoGX7nqdxw6PumGKt2Mo0x3AAnT58jde54vvGHd9KD3vCvqafTUnjOd1IpDIm6f6Jwfm8kJnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=uOWaxw/G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LHwVWWlV; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C54A2140040E;
	Wed,  3 Sep 2025 09:20:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 09:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756905653; x=
	1756992053; bh=gjSVmTZLOc7Cyb4WoSyeBbKN9tzEG7g1y0LgWwPh1pw=; b=u
	OWaxw/G3Dc/BtZSjEZj3nE7VeUh40qhoedOs2WLwJ21+7beugkSC9hzyJBNm47z/
	GFP+DEmODwVpD52hOl4YVbcRrsOYVH5LHT+RKN8rMM3G2DrBHzJhQ40sQrzjWOjq
	VtRFtv6mGp25WkJSg6AzTsPE5kjIAdqKGbfybEwMc1imhWHzURzxCzohkfW0UKQz
	JO8o7hq+xp2rur/o8kXFdw5f5q9iu8DJWaeqSJiygIR/NTjKmVhNK8ExB4EsLssT
	tp9Uzx3AvRAkNBizYHTx5Z9TdCjhTQgKB2+F1vlkEAcAx2TgJRSuKhuuFgwxIVkj
	cEvdpxRe8InYGyJ8Io0eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756905653; x=1756992053; bh=gjSVmTZLOc7Cyb4WoSyeBbKN9tzEG7g1y0L
	gWwPh1pw=; b=LHwVWWlVofGwBRWzJ7s7qLelajjRh4pq92A5ib2nCE7Fo2oY+19
	07fk0gcOkIoOeBr4pEbBfWxQgjYF+5Z4VrZZqG9/T/xB5eBzLAvqt6yrTLViuMQZ
	BcaMa2EaSt0v0aDbRNLGmtYtv9KAKt9eQ+biPB8jSSg5sWgPdr37mHQn02Ia2xnT
	IiU0A+xf3+88bNwReHJNzPEzsbgIfqAVTpzthDo4ugGgipf2JIYHP/btaBZ2L/SA
	AlOk+uLXmWWlsXVxpt/Y6FW/MKsBZaMqN8gjRpyeZDFcaoM4iBWu950RuzsqA14X
	4DSzaCZs1YCVD19wbQ0lyDwPxJCpab2JBMA==
X-ME-Sender: <xms:tUC4aJ5LMuGH5bgwh6elT6SFvIHH-E2tWf22cOrZdY1rAqI-DPa_MA>
    <xme:tUC4aAVcQ3nF3s7paJ1C5ez4lDtK9vGBghKOGvk7bGsTZz0PuhwNXbLgos67Xs-CM
    3pa9xU9iumuykmyPlg>
X-ME-Received: <xmr:tUC4aAD6jJ8ILBoOkRNhAJXQBcWxSFFArObrQN9cryyTFGhGNLl-MBeL-PFTzH7Hvr4ryEvhOZnMV1JpYGMFYVLTm6u0bnDWtNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhfdukeffhe
    ekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhishhtvghrmhhiug
    hisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlhes
    lhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhk
    hheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:tUC4aH6FjZdpFkP0e2kOK8FA1iTAeF4S2TyySOdftEoZFMlKHJuOgg>
    <xmx:tUC4aDzxhRyL9qy7nvxkv-JmESpFmm5riSYsLDxw0N53FIX2N2L_vg>
    <xmx:tUC4aGwxJoqjbOElErINWszDdJMybQwyaY-kKOo9XkURT2NTotO3uA>
    <xmx:tUC4aDw9299g_a2jnibR_0CP3p_MCov6VtX9rMKIFR9lH7hO45ozWQ>
    <xmx:tUC4aFz0UJaLsWNOVwa0g_sqAUFAkI4Li-pq7SIQQC-8VEZDNY31DBdK>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 09:20:52 -0400 (EDT)
Date: Wed, 3 Sep 2025 22:20:48 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Aleksandr Shabelnikov <mistermidi@gmail.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] firewire: core: bound traversal stack in
 read_config_rom()
Message-ID: <20250903132048.GA77442@workstation.local>
Mail-Followup-To: Aleksandr Shabelnikov <mistermidi@gmail.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
References: <20250902092745.8326-1-mistermidi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902092745.8326-1-mistermidi@gmail.com>

Hi,

Thanks for the patch.

On Tue, Sep 02, 2025 at 11:27:45AM +0200, Aleksandr Shabelnikov wrote:
> read_config_rom() walks Configuration ROM directories using an explicit
> stack but pushes new entries without a bound check:
> 
>     stack[sp++] = i + rom[i];
> 
> A malicious or malformed Configuration ROM can construct in-range cyclic
> directory references so that the traversal keeps enqueueing, growing the
> stack past its allocated depth. rom[] and stack[] are allocated adjacent
> in a single kmalloc() block, so this leads to a heap out-of-bounds write.
> 
> Add a hard bound check before every push. While this does not itself
> implement cycle detection, it prevents memory corruption and limits the
> impact to a clean failure (-EOVERFLOW).
> 
> Signed-off-by: Aleksandr Shabelnikov <mistermidi@gmail.com>
> ---
> v2:
>   - Drop Reported-by / Suggested-by trailers (per Greg KH)
> ---
>  drivers/firewire/core-device.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

For this kind of issue, I always hesitate to accept such changes, since
they addresses to an unreal problem. Moreover, IEEE 1394 is already a
legacy technology, and has been abandoned by vendors and manufacturers.
It is hardly plausible that such malicious content of configuration ROM
would be spread widely in recent years.

Nevertheless, from the perspective of building a robust software stack,
I can recognize the merit of your proposal. For this aim, I suggest you
consider working with KUnit[1].

The following change allows us to provide a customized read function to
the relevant function in any KUnit test suite. You can find some existing
examples of Kunit tests in the following files:

* drivers/firewire/device-attribute-test.c
* drivers/firewire/ohci-serdes-test.c
* drivers/firewire/packet-serdes-test.c
* drivers/firewire/self-id-sequence-helper-test.c
* drivers/firewire/uapi-test.c

Contributions to this subsystem may not provide a strong advantage to
your career as a software engineer. However, knowledge and experience
with the KUnit framework will certainly be valuable and beneficial. If
you are still motivated, I encourage you to give it a try.

[1] https://docs.kernel.org/dev-tools/kunit/index.html

```
$ git diff
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 4125e9e8..0987f7fe 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -575,7 +575,8 @@ static int read_rom(struct fw_device *device,
  * are reading the ROM may have changed the ROM during the reset.
  * Returns either a result code or a negative error code.
  */
-static int read_config_rom(struct fw_device *device, int generation)
+static int read_config_rom(struct fw_device *device, int generation,
+                          int (*read_fn)(struct fw_device *, int, int, u32 *))
 {
        struct fw_card *card = device->card;
        const u32 *old_rom, *new_rom;
@@ -595,7 +596,7 @@ static int read_config_rom(struct fw_device *device, int generation)

        /* First read the bus info block. */
        for (i = 0; i < 5; i++) {
-               ret = read_rom(device, generation, i, &rom[i]);
+               ret = read_fn(device, generation, i, &rom[i]);
                if (ret != RCODE_COMPLETE)
                        goto out;
                /*
@@ -633,7 +634,7 @@ static int read_config_rom(struct fw_device *device, int generation)
                        device->max_speed = card->link_speed;

                while (device->max_speed > SCODE_100) {
-                       if (read_rom(device, generation, 0, &dummy) ==
+                       if (read_fn(device, generation, 0, &dummy) ==
                            RCODE_COMPLETE)
                                break;
                        device->max_speed--;
@@ -665,7 +666,7 @@ static int read_config_rom(struct fw_device *device, int generation)
                }

                /* Read header quadlet for the block to get the length. */
-               ret = read_rom(device, generation, i, &rom[i]);
+               ret = read_fn(device, generation, i, &rom[i]);
                if (ret != RCODE_COMPLETE)
                        goto out;
                end = i + (rom[i] >> 16) + 1;
@@ -689,7 +690,7 @@ static int read_config_rom(struct fw_device *device, int generation)
                 * it references another block, and push it in that case.
                 */
                for (; i < end; i++) {
-                       ret = read_rom(device, generation, i, &rom[i]);
+                       ret = read_fn(device, generation, i, &rom[i]);
                        if (ret != RCODE_COMPLETE)
                                goto out;

@@ -1014,7 +1015,7 @@ static void fw_device_init(struct work_struct *work)
         * device.
         */

-       ret = read_config_rom(device, device->generation);
+       ret = read_config_rom(device, device->generation, read_rom);
        if (ret != RCODE_COMPLETE) {
                if (device->config_rom_retries < MAX_RETRIES &&
                    atomic_read(&device->state) == FW_DEVICE_INITIALIZING) {
@@ -1207,7 +1208,7 @@ static void fw_device_refresh(struct work_struct *work)
         */
        device_for_each_child(&device->device, NULL, shutdown_unit);

-       ret = read_config_rom(device, device->generation);
+       ret = read_config_rom(device, device->generation, read_rom);
        if (ret != RCODE_COMPLETE)
                goto failed_config_rom;

``


Thanks

Takashi Sakamoto

